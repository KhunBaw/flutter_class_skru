import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_class2/models/pokemon.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  List<Pokemon> pokemonData = [];
  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  void getPokemon() async {
    final response = await Dio().get("https://raw.githubusercontent.com/KhunBaw/testProject/main/pokemon-init-db.json");

    setState(() {
      pokemonData = pokemonFromJson(response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text(
          "Pokemon Dex",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: pokemonData.length,
        itemBuilder: (context, index) {
          final pokemon = pokemonData[index];
          return ListTile(
            leading: Image.network(
              pokemon.img,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
            title: Text(pokemon.name),
          );
        },
      ),
    );
  }
}
