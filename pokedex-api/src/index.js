const express = require('express');
const db = require('./queries');
const app = express();
const port = 3000;

app.use(express.json());

app.get('/pokemons', db.getPokemons);
app.post('/login', db.login);

app.listen(port, () => {
  console.log(`App running on port ${port}.`);
});
