<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
require_once 'db.php';
$token = $_GET['token'];

if($token !== 'pizza_admin_token') {
    echo json_encode(['success' => false, 'message' => 'Accès refusé']);
    exit();
}

$stmt = $pdo->query('SELECT c.ID_commande, c.nom_prenom, c.date_heure, p.nom, cp.quantite 
      FROM commandes c 
      JOIN commandes_pizzas cp ON c.ID_commande = cp.ID_commande 
      JOIN pizzas p ON cp.ID_pizza = p.ID');
$commandes = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($commandes, JSON_UNESCAPED_UNICODE);
?>
