<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

include 'connection.php';

$sql = "SELECT Cart.*, Products.* FROM Cart INNER JOIN Products ON Cart.product_id = Products.id";
$result = $conn->query($sql);

$cartItems = array();
while($row = $result->fetch_assoc()) {
  $cartItems[] = array(
    'id' => $row['product_id'],
    'quantity' => $row['quantity'],
    'product' => array(
      'id' => $row['product_id'],
      'name' => $row['name'],
      'brand' => $row['brand'],
      'price' => $row['price'],
      'image_path' => $row['image_path'],
      'description' => $row['description']
    )
  );
}
echo json_encode($cartItems);

$conn->close();
?>
