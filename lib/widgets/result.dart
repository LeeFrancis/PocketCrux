import 'package:flutter/material.dart';
import 'package:redux_items/model/result.dart';
import 'package:redux_items/widgets/view_model.dart';

class ResultWidget extends StatelessWidget {
  final ViewModel model;

  ResultWidget(this.model);

  Widget _createTile(Result result) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            title: Text(
              result.title?.value ?? "N/A",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                Text(result.abstract?.abstract,
                    style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          model.results.map((Result result) => _createTile(result)).toList(),
    );
  }
}
