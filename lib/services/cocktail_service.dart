

import 'dart:convert';

import 'package:proyect/models/cocktail.dart';
import 'package:http/http.dart' as http;

class CocktailService{
  final String baseUrlSearchByName = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=';

  final String baseUrlLookupById = 'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=';


  Future <ApiResponse> getCocktailsByName(String name) async{
    final response = await http.get(Uri.parse('$baseUrlSearchByName$name'));
    if(response.statusCode == 200){
      final result= jsonDecode(response.body);
      return ApiResponse.fromJson(result);
    }else{
      throw Exception('Failed to load cocktails');
    }
  }

  Future <Cocktail> getCocktailById(String id) async{
    final response = await http.get(Uri.parse('$baseUrlLookupById$id'));
    if(response.statusCode == 200){
      final result= jsonDecode(response.body);
      return Cocktail.fromJson(result['drinks'][0]);
    }else{
      throw Exception('Failed to load cocktail');
    }
  }

}