<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
require_once 'db.php';

$data = json_decode(file_get_contents('php://input'), true);
$login = $data['login'];
$mdp = $data['mdp'];

$stmt = $pdo->prepare('SELECT * FROM admin WHERE login = ? AND mdp = SHA2(?, 256)');
$stmt->execute([$login, $mdp]);
$admin = $stmt->fetch(PDO::FETCH_ASSOC);

if($admin) {
    echo json_encode(['success' => true, 'token' => 'pizza_admin_token']);}
else{
    echo json_encode(['succes' => false, 'message' => 'identifiants incorrects']);
}
?>
