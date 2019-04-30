import 'package:flutter/material.dart';
import 'package:redux_items/widgets/view_model.dart';

class SearchBox extends StatelessWidget {
  TextEditingController editingController = TextEditingController();
  final ViewModel model;

  SearchBox(this.model);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      onSubmitted: (v) {
        model.onDoSearch(editingController.text);
      },
      decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }
}
