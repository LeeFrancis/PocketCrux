import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:redux_items/model/results.dart';
import 'package:redux_items/redux/search_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:redux_items/model/model.dart';
import 'package:redux_items/redux/actions.dart';

List<Middleware<AppState>> appStateMiddleware([
  AppState state = const AppState(items: [], results: []),
]) {
  final loadItems = _loadFromPrefs(state);
  final saveItems = _saveToPrefs(state);
  final fetchResults = _fetchResults(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemsAction>(saveItems),
    TypedMiddleware<AppState, GetItemsAction>(loadItems),
    TypedMiddleware<AppState, FetchResultsAction>(fetchResults),
  ];
}

Middleware<AppState> _fetchResults(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    final api =
        new SearchApi(action.query); // Create our pseudo-api for fetching todos
    api.fetchResults().then((String str) {
      // If it succeeds, dispatch a success action with the todos.
      // Our reducer will then update the State using these todos.
      final parsed = json.decode(str);
      if (parsed['status'] == 401) {
        store.dispatch(new FetchResultsFailedAction({"message": "401"}));
      } else {
        Results results = Results.fromJson(parsed);
        store.dispatch(FetchResultsSucceededAction(results?.search?.results));
      }
    }).catchError((Object error) {
      // If it fails, dispatch a failure action. The reducer will
      // update the state with the error.
      store.dispatch(new FetchResultsFailedAction(error));
    });
  };
}

Middleware<AppState> _loadFromPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    loadFromPrefs().then((AppState state) {
      store.dispatch(LoadedItemsAction(state.items));
      store.dispatch(FetchResultsSucceededAction(state.results));
    });
  };
}

Middleware<AppState> _saveToPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    saveToPrefs(store.state);
  };
}

void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString('pocketCRUXState', string);
}

Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('pocketCRUXState');
  if (string != null) {
    Map map = json.decode(string);
    return AppState.fromJson(map);
  }
  return AppState.initialState();
}
