<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');

require_once 'db.php';
$data = json_decode(file_get_contents('php://input'), true);
$nom_prenom = $data['nom_prenom'];
 
$stmt = $pdo->prepare('INSERT INTO commandes (nom_prenom, date_heure) VALUES  (?, NOW())');
$stmt->execute([$nom_prenom]);

$id_commande = $pdo->lastInsertId();

foreach($data['pizzas'] as $pizza) {
    $stmt2 = $pdo->prepare('INSERT INTO commandes_pizzas (ID_commande, ID_pizza, quantite) VALUES (?, ?, ?)');
    $stmt2->execute([$id_commande, $pizza['ID_pizza'], $pizza['quantite']]);
}

echo json_encode(['succes' => true, 'message' => 'votre commande est en cours de preparation']);
?>
