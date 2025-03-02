import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_app/data/categories.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  int _enteredQuantity = 0;

  Category _selectedCategory = categories[Categories.fruit]!;

  bool _isLoading = false;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
      _isLoading = true;
        
      });


      /*log(_enteredName);
                            log(_enteredQuantity.toString());
                            log(_selectedCategory.toString());*/

      final Uri url = Uri.https(
          "flutter-test-40cbf-default-rtdb.firebaseio.com",
          "shopping-list.json");
      http
          .post(url,
              headers: {"Content-Type": "application/json"},
              body: json.encode({
                "name": _enteredName,
                "quantity": _enteredQuantity,
                "category": _selectedCategory.title
              }))
          .then((res) {
        log(res.body);
        final Map<String, dynamic> resData = json.decode(res.body);
        if (res.statusCode == 200) {
          Navigator.of(context).pop(GroceryItem(
              id: resData['name'],
              name: _enteredName,
              quantity: _enteredQuantity,
              category: _selectedCategory));
        }
      });

      /* Navigator.of(context).pop(GroceryItem(
                                id: DateTime.now().toString(),
                                name: _enteredName,
                                quantity: _enteredQuantity,
                                category: _selectedCategory));*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Add New Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  onSaved: (newValue) {
                    _enteredName = newValue!;
                  },
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return "Name not correct ";
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: TextFormField(
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        _enteredQuantity = int.parse(newValue!);
                      },
                      decoration: InputDecoration(
                        labelText: "Quantity",
                      ),
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return "Number invalid";
                        }
                        return null;
                      },
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: DropdownButtonFormField(
                            value: _selectedCategory,
                            items: [
                              for (final category in categories.entries)
                                DropdownMenuItem(
                                    value: category.value,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 16,
                                          width: 16,
                                          color: category.value.color,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(category.value.title)
                                      ],
                                    ))
                            ],
                            onChanged: (Category? value) {
                              setState(() {
                                _selectedCategory = value!;
                              });
                            }))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: Text("Reset")),
                    ElevatedButton(
                        onPressed: _isLoading ? null : _saveItem,
                        child: _isLoading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text("Add Item"))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
