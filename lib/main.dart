import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';

import 'package:redux_items/model/model.dart';
import 'package:redux_items/redux/actions.dart';
import 'package:redux_items/redux/reducers.dart';
import 'package:redux_items/redux/middleware.dart';
import 'package:redux_items/widgets/view_model.dart';

import 'model/result.dart';
import 'widgets/result.dart';
import 'widgets/search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DevToolsStore<AppState> store = DevToolsStore<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
      middleware: appStateMiddleware(),
    );

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Pocket CRUX',
        theme: ThemeData.dark(),
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetItemsAction()),
          builder: (BuildContext context, Store<AppState> store) =>
              MyHomePage(store),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final DevToolsStore<AppState> store;

  MyHomePage(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pocket CRUX.'),
      ),
      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) => Column(
              children: <Widget>[
                SearchBox(viewModel),
                Expanded(child: ResultWidget(viewModel)),
              ],
            ),
      ),
      drawer: Container(
        child: ReduxDevTools(store),
      ),
    );
  }
}

class RemoveItemsButton extends StatelessWidget {
  final ViewModel model;

  RemoveItemsButton(this.model);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Delete all Items'),
      onPressed: () => model.onRemoveItems(),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final ViewModel model;

  ItemListWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: model.results
          .map((Result result) => ListTile(
                title: Text(result.title?.value),
              ))
          .toList(),
    );
  }
}

class AddItemWidget extends StatefulWidget {
  final ViewModel model;

  AddItemWidget(this.model);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'add an Item',
      ),
      onSubmitted: (String s) {
        widget.model.onAddItem(s);
        controller.text = '';
      },
    );
  }
}
