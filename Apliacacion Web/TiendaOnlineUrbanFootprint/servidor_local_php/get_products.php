<?php
header('Access-Control-Allow-Origin: *');

include 'connection.php';

$sql = "SELECT * FROM Products";
$result = $conn->query($sql);

$products = array();
while($row = $result->fetch_assoc()) {
  $products[] = $row;
}
echo json_encode($products);

$conn->close();
?>

