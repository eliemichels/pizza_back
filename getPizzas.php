<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once 'db.php';

$stmt = $pdo->query('SELECT * FROM pizzas');
$pizzas = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($pizzas, JSON_UNESCAPED_UNICODE);
?>
