import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_page_response.dart';

class PokemonRepository{
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async{

    final queryParameters = {'limit': "200",'offset': (pageIndex*200).toString()};

    final URI = Uri.https(baseUrl, '/api/v2/pokemon',queryParameters);

    final response = await client.get(URI);
    final json = jsonDecode(response.body);

    return PokemonPageResponse.fromJson(json);
  }
}