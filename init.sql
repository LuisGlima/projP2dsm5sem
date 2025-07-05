CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL
);

CREATE TABLE pokemons (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    tipo TEXT NOT NULL,
    imagem TEXT NOT NULL
);

INSERT INTO usuarios (email, senha) VALUES ('fatec@pokemon.com', 'pikachu');

INSERT INTO pokemons (id, nome, tipo, imagem) VALUES
(1, 'Bulbasaur', 'Grass/Poison', 'assets/images/bulbasaur.png'),
(2, 'Ivysaur', 'Grass/Poison', 'assets/images/ivysaur.png'),
(3, 'Venusaur', 'Grass/Poison', 'assets/images/venusaur.png'),
(4, 'Charmander', 'Fire', 'assets/images/charmander.png'),
(5, 'Charmeleon', 'Fire', 'assets/images/charmeleon.png'),
(6, 'Charizard', 'Fire/Flying', 'assets/images/charizard.png'),
(7, 'Squirtle', 'Water', 'assets/images/squirtle.png'),
(8, 'Wartortle', 'Water', 'assets/images/wartortle.png'),
(9, 'Blastoise', 'Water', 'assets/images/blastoise.png'),
(10, 'Caterpie', 'Bug', 'assets/images/caterpie.png');