require('dotenv').config();
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

db.connect((err) => {
  if(err) throw err;
  console.log('Connecté à la BDD');
});

// GET toutes les pizzas
app.get('/pizzas', (req, res) => {
  db.query('SELECT * FROM pizzas', (err, results) => {
    if(err) return res.status(500).json({error: "ya un probleme mdr"});
    res.json(results);
  });
});

// GET une pizza
app.get('/pizzas/:id', (req, res) => {
  db.query('SELECT * FROM pizzas WHERE ID = ?', [req.params.id], (err, results) => {
    if(err) return res.status(500).json({error: "ya un probleme mdr"});
    res.json(results[0]);
  });
});

// POST commande
app.post('/commandes', (req, res) => {
  const { nom_prenom, pizzas } = req.body;
  db.query('INSERT INTO commandes (nom_prenom, date_heure) VALUES (?, NOW())', [nom_prenom], (err, result) => {
    if(err) return res.status(500).json({error: "ya un probleme mdr"});
    const id_commande = result.insertId;
    pizzas.forEach(pizza => {
      db.query('INSERT INTO commandes_pizzas (ID_commande, ID_pizza, quantite) VALUES (?, ?, ?)',
        [id_commande, pizza.ID_pizza, pizza.quantite]);
    });
    res.json({ success: true, message: 'Commande en cours de préparation' });
  });
});

// POST login admin
app.post('/login', (req, res) => {
  const { login, mdp } = req.body;
  db.query('SELECT * FROM admin WHERE login = ? AND mdp = SHA2(?, 256)', [login, mdp], (err, results) => {
    if(err) return res.status(500).json({error : "ya un probleme mdr"});
    if(results.length > 0) {
      res.json({ success: true, token: 'pizza_admin_token' });
    } else {
      res.json({ success: false, message: 'Identifiants incorrects' });
    }
  });
});

// GET commandes admin
app.get('/commandes', (req, res) => {
  const token = req.query.token;
  if(token !== 'pizza_admin_token') {
    return res.json({ success: false, message: 'Accès refusé' });
  }
  db.query(`SELECT c.ID_commande, c.nom_prenom, c.date_heure, p.nom, cp.quantite 
            FROM commandes c 
            JOIN commandes_pizzas cp ON c.ID_commande = cp.ID_commande 
            JOIN pizzas p ON cp.ID_pizza = p.ID`, (err, results) => {
    if(err) return res.status(500).json({ error: "ya un probleme mdr"}) ;
    res.json(results);
  });
});

app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});
