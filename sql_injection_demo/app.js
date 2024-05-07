const mysql = require('mysql');
const express = require('express');
const app = express();
app.use(express.json());

const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    multipleStatements: true
});

app.post('/products', (req, res) => {
    let productId = req.body.productId;
    let query = 'SELECT * FROM products WHERE id = ?';
    connection.query(query, [productId], (error, results) => {
        if (error) {
            console.error('SQL Error:', error);
            return res.status(500).send('An error occurred: ' + error.sqlMessage);
        }
        if (results.length > 0) {
            res.json(results);
        } else {
            res.status(404).send('No products found');
        }
    });
});
app.listen(3000, () => console.log('App running on port 3000'));
