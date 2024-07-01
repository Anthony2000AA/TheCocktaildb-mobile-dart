

import 'package:flutter/material.dart';
import 'package:proyect/models/cocktail.dart';
import 'package:proyect/services/cocktail_service.dart';

class CocktailDetail extends StatefulWidget {
  const CocktailDetail({Key? key, required this.idCocktail}) : super(key: key);
  final String idCocktail;

  @override
  State<CocktailDetail> createState() => _CocktailDetailState();
}

class _CocktailDetailState extends State<CocktailDetail> {

  final _cocktailService = CocktailService();
  Cocktail? _cocktail;

  initalize() async{
    final cocktail = await _cocktailService.getCocktailById(widget.idCocktail);
    setState(() {
      _cocktail = cocktail;
    });
  }
  @override
  void initState() {
    initalize();
    super.initState();
  }

  


  @override
  Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Detail'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _cocktail == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(_cocktail!.strDrinkThumb),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _cocktail!.strDrink,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _cocktail!.strCategory,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _cocktail!.strInstructions,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Add more details if necessary
                  ],
                ),
              ),
            ),
    );
  }
}