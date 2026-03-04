<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once 'db.php';

$stmt = $pdo->prepare('SELECT * FROM pizzas WHERE ID = ?');
$id = $_GET['id'];
$stmt->execute([$id]);
$pizza = $stmt->fetch(PDO::FETCH_ASSOC);

echo json_encode($pizza, JSON_UNESCAPED_UNICODE);
?>
