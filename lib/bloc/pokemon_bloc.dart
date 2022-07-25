import 'package:pokedex/pokemon_page_response.dart';
import 'package:pokedex/pokemon_repository.dart';

import 'pokemon_event.dart';
import 'pokemon_state.dart';
import 'package:bloc/bloc.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState>{
  PokemonBloc() : super(PokemonInitial());

  final _pokemonRepository = PokemonRepository();

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async*{
    if(event is PokemonPageRequest){
      yield PokemonLoadInProgress();

      try{
        final PokemonPageResponse = await _pokemonRepository.getPokemonPage(event.page);
        yield PokemonPageLoadSuccess(
            pokemonListings: PokemonPageResponse.pokemonListings,
            canLoadNextPage: PokemonPageResponse.canLoadNextPage
        );

      } on Error catch (e) {
        yield PokemonPageLoadFailed(error: e);
      }
    }
  }

}
