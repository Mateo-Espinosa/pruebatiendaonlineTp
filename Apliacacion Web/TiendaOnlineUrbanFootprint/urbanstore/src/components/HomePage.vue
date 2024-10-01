<template>
  <div>
    <header>
      <h1>Urban Footprint</h1>
        <button id="gocart" @click="$router.push('/cart')" style="float: right;">Ir al carrito</button> <!-- Agregar el botón del carrito a la esquina -->
    </header>

    <h1 class="tilte">Bienvenido a nuestra tienda de zapatos</h1>
    <div v-if="loading">Cargando productos...</div>
    <div v-else class="product-grid">
      <div v-for="(product, index) in products" :key="product.id" class="product-card">
        <div class="card">
          <img :src="product.image_path" alt="Imagen del producto" class="product-image" />
          <div class="card-content">
            <h2 class="product-name">{{ product.name }}</h2>
            <p class="product-brand">{{ product.brand }}</p>
            <p class="product-price">${{ product.price }}</p>
            <button class="add-to-cart-button" @click="addToCart(product)" :disabled="isInCart(product)">{{ isInCart(product) ? 'En el carrito' : 'Agregar al carrito' }}</button>
          </div>
        </div>
        <!-- Agregar un salto de línea después de cada cuarto producto -->
        <div v-if="(index + 1) % 4 === 0" style="flex-basis: 100%; height: 0;"></div>
      </div>
    </div>
    <div v-if="showToast" class="toast">
      {{ toastMessage }}
    </div>

    <div class="foot">
      <p>© 2024 Urban Footprint</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'HomePage',
  data() {
    return {
      products: [],
      cartItems: [],
      loading: true,
      showToast: false,
      toastMessage: '',
    }
  },
  methods: {
    async addToCart(product) {
      if (this.isInCart(product)) {
        this.toastMessage = product.name + ' ya está en el carrito';
        this.showToast = true;
        setTimeout(() => {
          this.showToast = false;
        }, 3000);
        return;
      }

      try {
        const response = await axios.post('http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/cart.php', {
          product_id: product.id,
          quantity: 1, 
        }, {
          headers: {
            'Content-Type': 'application/json',
          }
        })

        if (response.data && response.data.success) {
          this.cartItems.push(product);
          this.toastMessage = product.name + ' agregado al carrito';
          this.showToast = true;
          setTimeout(() => {
            this.showToast = false;
          }, 3000);
        } else {
          console.error('Error al agregar al carrito:', response.data ? response.data.error : 'No data in response')
        }
      } catch (error) {
        console.error('Error al agregar al carrito:', error)
        if (error.response) {
          console.error('Error data:', error.response.data);
          console.error('Error status:', error.response.status);
          console.error('Error headers:', error.response.headers);
        } else if (error.request) {
          console.error('Error request:', error.request);
        } else {
          console.error('Error message:', error.message);
        }
        console.error('Error config:', error.config);
      }
    },
    isInCart(product) {
      return this.cartItems.some(item => item.id === product.id);
    },
    goToCart() {
      this.$router.push('/cart');
    },
  },
  async created() {
    try {
      const response = await axios.get('http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/get_products.php')
      this.products = response.data
      console.log(this.products) 
    } catch (error) {
      console.error('Error al obtener los productos:', error)
    } finally {
      this.loading = false
    }
  },
}
</script>

<style>
header {
  background-color: #3f51b5;
  color: #fff;
  padding: 20px;
  text-align: center;
  width: 100%;
  height: 100px;
}

header h1 {
  margin: 0;
  display: inline-block; 
}

#gocart {
  background: transparent;
  color: black;
  float: right; 
}

.categories {
  display: flex;
  justify-content: space-around;
  margin-top: 20px;
}

.foot {
  background-color: #3f51b5;
  color: #fff;
  text-align: center;
  padding: 20px;
  position: fixed;
  bottom: 0;
  width: 100%;
height: 10px;
}

.product-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  margin-top:1.5rem;
  margin-bottom: 2rem; 
}

.product-card {
  border: 1px solid #ccc;
  border-radius: 12px;
  padding: 9px;
  margin: 10px;
  width: calc(25% - 20px); 
}

.product-image {
  border-radius: 15px;
  width: 100%;
  height: 200px;
  object-fit: cover; 
}

.product-name {
  font-size: 20px;
  font-weight: bold;
}

.product-brand {
  color: #666;
}

.product-price {
  color: #333;
  font-size: 18px;
  margin: 10px 0;
}

.add-to-cart-button {
  background-color: #3f51b5;
  color: #fff;
  border: none;
  border-radius: 5px;
  padding: 10px 15px;
  cursor: pointer;
}

.toast {
  position: fixed;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  background-color: #333;
  color: #fff;
  padding: 10px 20px;
  border-radius: 5px;
  z-index: 1000;
}

.categories button {
  background-color: #fff;
  border: none;
  color: black;
  padding: 10px 20px;
  cursor: pointer;
  font-size: 16px;
  width: 150px;
  border-radius: 8px;
}

.tilte {
  text-align: center;
  margin-top: 2rem;
}

.foot {
  margin-top: 2rem;
  padding-bottom: 2rem; 
}
#gocart {
  color: white;
  font-weight: bold;
}


</style>
