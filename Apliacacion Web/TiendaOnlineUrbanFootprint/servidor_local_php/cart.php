<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

include 'connection.php';

$data = json_decode(file_get_contents('php://input'), true);
$product_id = $data['product_id'];
$quantity = $data['quantity'];

$check_sql = "SELECT * FROM Cart WHERE product_id = ?";
$check_stmt = $conn->prepare($check_sql);
$check_stmt->bind_param("i", $product_id);
$check_stmt->execute();
$result = $check_stmt->get_result();

if ($result->num_rows > 0) {
    echo json_encode(['success' => false, 'error' => 'El producto ya está en el carrito']);
} else {
    $sql = "INSERT INTO Cart (product_id, quantity) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $product_id, $quantity);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => $stmt->error]);
    }
}

$conn->close();
?>
