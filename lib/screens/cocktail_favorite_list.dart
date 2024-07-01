

import 'package:flutter/material.dart';
import 'package:proyect/dao/cocktail_dao.dart';

class CocktailFavoriteList extends StatefulWidget {
  const CocktailFavoriteList({super.key});

  @override
  State<CocktailFavoriteList> createState() => _CocktailFavoriteListState();
}

class _CocktailFavoriteListState extends State<CocktailFavoriteList> {

  List _cocktailsFavorites = [];
  final _cocktailDao = CocktailDao(); 

  initalize() async{
    _cocktailsFavorites = await _cocktailDao.getAll();

    if(mounted){
      setState(() {
        _cocktailsFavorites = _cocktailsFavorites;   
      });
    }
  }

  @override
  void initState() {
    initalize();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Cocktails'),
      ),
      body: ListView.builder(
        itemCount: _cocktailsFavorites.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(_cocktailsFavorites[index].strDrink),
            leading: Image.network(_cocktailsFavorites[index].strDrinkThumb),
            subtitle: Text(_cocktailsFavorites[index].strCategory),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){
                _cocktailDao.delete(_cocktailsFavorites[index].idDrink);
                initalize();
              },
            ),
          );
        }
      ),
    );
  }
}