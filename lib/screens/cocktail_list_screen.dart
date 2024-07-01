import 'package:flutter/material.dart';
import 'package:proyect/dao/cocktail_dao.dart';
import 'package:proyect/models/cocktail.dart';
import 'package:proyect/screens/cocktail_detail.dart';
import 'package:proyect/services/cocktail_service.dart';

class CocktailListScreen extends StatefulWidget {
  const CocktailListScreen({super.key});

  @override
  State<CocktailListScreen> createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {

  final _searchController = TextEditingController();
  String _name = '';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: PreferredSize(
          preferredSize: const  Size.fromHeight(150),
          child: SafeArea(
            child: Column(
              children:[
                const Text(
                  "Search for your favorite cocktail",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const  EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter cocktail name',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  
                    )
                  )
                ]
              )
            )

          ),
        body: CocktailList(query: _name,)


      );         
  }
}

class CocktailList extends StatefulWidget {
  const CocktailList({super.key, required this.query});
  final String query;

  @override
  State<CocktailList> createState() => _CocktailListState();
}

class _CocktailListState extends State<CocktailList> {

  List<Cocktail> _cocktails = [];
  final _cocktailService = CocktailService();

  @override
  void initState() {
    initialize();
    super.initState();
    
  }

  initialize() async{
    if(widget.query.isEmpty){
      return;
    }
    final apiResponse = await _cocktailService.getCocktailsByName(widget.query);
    setState(() {
      _cocktails = apiResponse.drinks;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(widget.query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: _cocktailService.getCocktailsByName(widget.query),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasError){
          return Center( child: Text('El cocktail ${widget.query} no se encuentra disponible'));
          
        }else{
          _cocktails = snapshot.data!.drinks;

          return ListView.builder(
            itemCount: _cocktails.length,
            itemBuilder: (context, index){
              return CocktailItem(cocktail: _cocktails[index]);
            }
          );
        }
      }
    );


  }
}


class CocktailItem extends StatefulWidget {
  const CocktailItem({super.key, required this.cocktail});

  final Cocktail cocktail;

  @override
  State<CocktailItem> createState() => _CocktailItemState();
}

class _CocktailItemState extends State<CocktailItem> {

  bool _isFavorite = false;
  final _cocktailDao = CocktailDao();

  initialize() async{
    _isFavorite = await _cocktailDao.isFavorite(widget.cocktail.idDrink);
    if(mounted){
      setState(() {
       
      });
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CocktailDetail(idCocktail: widget.cocktail.idDrink)
          )
        );

      },
      child: Card(
        child: ListTile(
          title: Text(widget.cocktail.strDrink),
          leading: Image.network(widget.cocktail.strDrinkThumb),
          subtitle: Text(widget.cocktail.strCategory),
          trailing: IconButton(
            icon: _isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
            color: _isFavorite ? Colors.red : Colors.grey,
            onPressed: (){
              setState(() {
                _isFavorite = !_isFavorite;
              });
              _isFavorite ? _cocktailDao.insert(widget.cocktail) : _cocktailDao.delete(widget.cocktail.idDrink);
            },
          ),
          
        )
      )
    );
  }
}