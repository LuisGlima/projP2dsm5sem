import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/pokemon.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  Color _getCardColor(String type) {
    switch (type) {
      case 'Grass/Poison':
        return Colors.lightGreen[100]!;
      case 'Fire':
        return Colors.red[100]!;
      case 'Water':
        return Colors.blue[100]!;
      case 'Bug':
        return Colors.lightGreen[300]!; // Moss green
      default:
        return Colors.white;
    }
  }

  Color _getTypeChipColor(String type) {
    switch (type) {
      case 'Grass/Poison':
        return Colors.lightGreen[400]!;
      case 'Fire':
        return Colors.red[400]!;
      case 'Water':
        return Colors.blue[400]!;
      case 'Bug':
        return Colors.lightGreen[600]!;
      default:
        return Colors.grey[400]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokédex",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: dbHelper.getPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Pokemons found.'));
          }

          final pokemons = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final p = pokemons[index];
              return Card(
                color: _getCardColor(p.tipo),
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        p.imagem,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.nome,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: _getTypeChipColor(p.tipo),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              p.tipo,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
