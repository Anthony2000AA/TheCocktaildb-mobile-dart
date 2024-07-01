
class ApiResponse{

  final List<Cocktail> drinks;

  ApiResponse({ required this.drinks});

  ApiResponse.fromJson(Map<String, dynamic> json)
    : drinks = (json['drinks'] as List).map((e) => Cocktail.fromJson(e)).toList();



}

class Cocktail{
  final String idDrink;
  final String strDrink;
  final String strDrinkAlternate;
  final String strTags;
  final String strCategory;
  final String strAlcoholic;
  final String strGlass;
  final String strInstructions;
  final String strDrinkThumb;

  Cocktail({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkAlternate,
    required this.strTags,
    required this.strCategory,
    required this.strAlcoholic,
    required this.strGlass,
    required this.strInstructions,
    required this.strDrinkThumb
  });

  Cocktail.fromJson(Map<String, dynamic> json)
    : idDrink = json['idDrink'] ?? 'null',
      strDrink = json['strDrink'] ?? 'null',
      strDrinkAlternate = json['strDrinkAlternate'] ?? 'null',
      strTags = json['strTags'] ?? 'null',
      strCategory = json['strCategory'] ?? 'null',
      strAlcoholic = json['strAlcoholic'] ?? 'null',
      strGlass = json['strGlass'] ?? 'null',
      strInstructions = json['strInstructions'] ?? 'null',
      strDrinkThumb = json['strDrinkThumb'] ?? 'null';

  
  Map<String, dynamic> toMap(){
    return {
      'idDrink': idDrink,
      'strDrink': strDrink,
      'strCategory': strCategory,
      'strDrinkThumb': strDrinkThumb
    };
    
  }

}

class CocktailFavortie{
  final String idDrink;
  final String strDrink;
  final String strCategory;
  final String strDrinkThumb;

  CocktailFavortie({
    required this.idDrink,
    required this.strDrink,
    required this.strCategory,
    required this.strDrinkThumb
  });

  
  CocktailFavortie.fromMap(Map<String, dynamic> map)
    : idDrink = map['idDrink'],
      strDrink = map['strDrink'],
      strCategory = map['strCategory'],
      strDrinkThumb = map['strDrinkThumb'];
}