import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/data/categories.dart';
import 'package:shop_app/models/category.dart';
// import 'package:shop_app/data/dummy_items.dart';
import 'package:shop_app/models/grocery_item.dart';
import 'package:shop_app/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _error;
  void _loadData() async {
    final Uri url = Uri.https("flutter-test-40cbf-default-rtdb.firebaseio.com",
        "shopping-list.json");
    final http.Response res = await http.get(url);
    //log(res.body.toString());
    print('res.statusCode=${res.statusCode}');

    if (res.statusCode >= 400){
      setState(() {
      _error= 'Failed to fetch Data !!';
        
      });
    }

    if (res.body == 'null'){
      setState(() {
        _isLoading =false ;
      });
      return;
    }

    final Map<String, dynamic> loadedData = json.decode(res.body);
    final List<GroceryItem> loadedItems = [];
    for (var item in loadedData.entries) {
      final Category category = categories.entries
          .firstWhere(
            (element) => element.value.title == item.value['category'],
          )
          .value;
      loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));

          setState(() {
            _groceryItems = loadedItems;
            _isLoading =false ;
          });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No Item added yet ."),
    );

    if (_isLoading) {
      content=const Center(
        child:CircularProgressIndicator() ,

      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(_groceryItems[index].id),
                onDismissed: (_) {
                  setState(() {
                    _groceryItems.remove(_groceryItems[index]);
                  });
                },
                child: ListTile(
                  title: Text(_groceryItems[index].name),
                  leading: Container(
                    height: 24,
                    width: 24,
                    color: _groceryItems[index].category.color,
                  ),
                  trailing: Text(_groceryItems[index].quantity.toString()),
                ),
              ));
    }

    if (_error != null){
      content =Center(child: Text(_error!),);

    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Grocery List"),
          actions: [
            IconButton(onPressed: () => _addItem(), icon: Icon(Icons.add))
          ],
        ),
        body: content);
  }

  _addItem() async {
    /* Navigator.of(context).push<GroceryItem>(
                    MaterialPageRoute(builder: (ctx) => const NewItem())).then((GroceryItem? value){
                     if (value == null) return ;
                     setState(() {
                       
                       _groceryItems.add(value);
                     });
                     
                    }) ;*/

     final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItem()));

  if (newItem != null) {
    setState(() {
      _groceryItems.add(newItem);
    });
  }
      
   // _loadData();m
  }
}
