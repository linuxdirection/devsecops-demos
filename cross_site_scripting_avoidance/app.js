const express = require('express');
const app = express();

app.get('/search', function(req, res) {
    // This line of code is vulnerable to XSS because user input is directly reflected back in the response without sanitization.
    const searchQuery = req.query.query; // User input is taken from the query parameter
    res.send('You searched for: ' + searchQuery); // User input is directly output to the browser
});

app.listen(3000, () => console.log('Server running on port 3000'));
