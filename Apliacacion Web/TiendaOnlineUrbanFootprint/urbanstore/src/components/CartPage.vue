<template>
  <div>
    <h1>Tu carrito</h1>
    <div v-if="loading">Cargando carrito...</div>
    <table v-else class="cart-table">
      <thead>
        <tr>
          <th>Producto</th>
          <th>Precio</th>
          <th>Cantidad</th>
          <th>Subtotal</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in cartItems" :key="item.id">
          <td>
            <img :src="item.product.image_path" alt="Imagen del producto" class="product-image" />
            <p>{{ item.product.name }}</p>
          </td>
          <td>${{ Number(item.product.price).toFixed(3) }}</td>
          <td>
            <button @click="decreaseQuantity(item)">-</button>
            {{ item.quantity }}
            <button @click="increaseQuantity(item)">+</button>
          </td>
          <td>${{ (Number(item.product.price) * item.quantity).toFixed(3) }}</td>
          <td><button @click="deleteFromCart(item)">Eliminar del carrito</button></td>
        </tr>
      </tbody>
    </table>
    <table class="total-table">
      <thead>
        <tr>
          <th>Total del carrito</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>${{ cartTotal.toFixed(3) }}</td>
        </tr>
      </tbody>
    </table>
    <button class="checkout-button" @click="openCheckoutDialog">Finalizar compra</button>
    <div v-if="showCheckoutDialog" class="checkout-dialog">
      <h2>Finalizar compra</h2>
      <div v-if="!showPaymentForm">
        <label>
          Nombre completo:
          <input v-model="checkoutForm.fullName" type="text" required />
        </label>
        <label>
          Correo electrónico:
          <input v-model="checkoutForm.email" type="email" required />
        </label>
        <label>
          Dirección:
          <input v-model="checkoutForm.address" type="text" required />
        </label>
        <div class="dialog-buttons">
          <button @click="next" :disabled="!checkoutForm.fullName || !checkoutForm.email || !checkoutForm.address">Siguiente</button>
          <button @click="closeCheckoutDialog">Cancelar</button>
        </div>
        <p v-if="showErrorMessage" class="error-message">Por favor, rellena todos los campos.</p>
      </div>
      <div v-else>
        <label>
          Número de tarjeta:
          <input v-model="checkoutForm.cardNumber" type="number" maxlength="16" required />
        </label>
        <label>
          CVS:
          <input v-model="checkoutForm.cvs" type="number" maxlength="3" required />
        </label>
        <label>
          Fecha de expedición:
          <input v-model="checkoutForm.expiryDate" type="date" required />
        </label>
        <div class="dialog-buttons">
          <button @click="submitCheckoutForm" :disabled="!checkoutForm.cardNumber || !checkoutForm.cvs || !checkoutForm.expiryDate">Enviar</button>
          <button @click="back">Atrás</button>
        </div>
        <p v-if="showErrorMessage" class="error-message">Por favor, rellena todos los campos.</p>
      </div>
    </div>
    <div v-if="showSuccessMessage" class="success-message">
      Compra realizada con éxito, llegará a tu correo toda la información.
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CartPage',
  data() {
    return {
      cartItems: [],
      loading: true,
      showCheckoutDialog: false,
      showPaymentForm: false,
      showSuccessMessage: false,
      showErrorMessage: false,
      checkoutForm: {
        fullName: '',
        address: '',
        email: '',
        cardNumber: '',
        cvs: '',
        expiryDate: '',
      },
    }
  },
  computed: {
    cartTotal() {
      return this.cartItems.reduce((total, item) => total + Number(item.product.price) * item.quantity, 0);
    },
  },
  methods: {
    async fetchCartItems() {
      try {
        const response = await axios.get('http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/get_products_cart.php')
        this.cartItems = response.data
      } catch (error) {
        console.error('Error al obtener los items del carrito:', error)
      } finally {
        this.loading = false
      }
    },
    async deleteFromCart(item) {
      try {
        const response = await axios.post('http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/delete_products_cart.php', {
          id: item.id,
        }, {
          headers: {
            'Content-Type': 'application/json',
          }
        })

        if (response.data && response.data.success) {
          this.cartItems = this.cartItems.filter(cartItem => cartItem.id !== item.id);
        } else {
          if (response.data && response.data.error) {
            console.error('Error al eliminar del carrito:', response.data.error)
          } else {
            console.error('Error al eliminar del carrito.')
          }
        }
      } catch (error) {
        console.error('Error al eliminar del carrito:', error)
      }
    },
    increaseQuantity(item) {
      item.quantity++;
    },
    decreaseQuantity(item) {
      if (item.quantity > 1) {
        item.quantity--;
      }
    },
    openCheckoutDialog() {
      this.showCheckoutDialog = true;
    },
    closeCheckoutDialog() {
      this.showCheckoutDialog = false;
      this.showPaymentForm = false;
      this.showErrorMessage = false;
    },
    next() {
      if (this.checkoutForm.fullName && this.checkoutForm.email && this.checkoutForm.address) {
        this.showPaymentForm = true;
        this.showErrorMessage = false;
      } else {
        this.showErrorMessage = true;
      }
    },
    back() {
      this.showPaymentForm = false;
      this.showErrorMessage = false;
    },
    submitCheckoutForm() {
      if (this.checkoutForm.cardNumber && this.checkoutForm.cvs && this.checkoutForm.expiryDate) {
        console.log('Formulario de compra enviado:', this.checkoutForm);
        this.showCheckoutDialog = false;
        this.showSuccessMessage = true;
        setTimeout(() => {
          this.showSuccessMessage = false;
        }, 5000);
      } else {
        this.showErrorMessage = true;
      }
    },
  },
  created() {
    this.fetchCartItems()
  },
}
</script>

<style scoped>
.cart-table,
.total-table {
  width: 100%;
  border-collapse: collapse;
}

.cart-table th,
.cart-table td,
.total-table th,
.total-table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center;
}

.cart-table th,
.total-table th {
  background-color: #f2f2f2;
}

.product-image {
  width: 50px;
  height: 50px;
  object-fit: cover;
}

button {
  background-color: #3f51b5;
  color: white;
  border: none;
  padding: 5px 10px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

.checkout-button {
  margin-top: 20px;
  display: block;
  width: 100%;
}

.checkout-dialog {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #fff;
  padding: 20px;
  border-radius: 10px;
  z-index: 1000;
}

.checkout-dialog label {
  display: block;
  margin-bottom: 10px;
}

.checkout-dialog input {
  width: 100%;
  padding: 5px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.dialog-buttons {
  display: flex;
  justify-content: space-between;
}

.error-message {
  color: red;
  margin-top: 10px;
}

.success-message {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #4CAF50;
  color: white;
  padding: 20px;
  border-radius: 5px;
  z-index: 1000;
  text-align: center;
}
</style>
