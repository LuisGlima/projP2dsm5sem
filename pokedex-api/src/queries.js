const Pool = require('pg').Pool;
const pool = new Pool({
  user: 'postgres',
  host: 'db',
  database: 'pokedex',
  password: 'postgres',
  port: 5432,
});

const getPokemons = (request, response) => {
  pool.query('SELECT * FROM pokemons ORDER BY id ASC', (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const login = (request, response) => {
  const { email, senha } = request.body;

  pool.query('SELECT * FROM usuarios WHERE email = $1 AND senha = $2', [email, senha], (error, results) => {
    if (error) {
      throw error;
    }
    if (results.rows.length > 0) {
        response.status(200).json(results.rows[0]);
    } else {
        response.status(401).send('Unauthorized');
    }
  });
};

module.exports = {
  getPokemons,
  login,
};