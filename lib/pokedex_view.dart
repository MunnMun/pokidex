import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon_state.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state){
        if(state is PokemonLoadInProgress){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is PokemonPageLoadSuccess){
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: state.pokemonListings.length ,
              itemBuilder: (context,index){
            return Card(child: GridTile(child: Column(children: [
              Image.network(state.pokemonListings[index].imageUrl),
              Text(state.pokemonListings[index].name)
            ],),));
          },
          );
        }else{
          return Container(
            child: Text('F load nhi hua'),
          );
        }
      }),
    );
  }
}
