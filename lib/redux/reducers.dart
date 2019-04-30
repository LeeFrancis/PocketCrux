import 'package:redux_items/model/model.dart';
import 'package:redux_items/model/result.dart';
import 'package:redux_items/redux/actions.dart';

import 'package:redux/redux.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
    results: resultsReducer(state.results, action),
  );
}

Reducer<List<Result>> resultsReducer = combineReducers<List<Result>>([
  TypedReducer<List<Result>, FetchResultsSucceededAction>(
      fetchResultsSucceededReducer),
  TypedReducer<List<Result>, FetchResultsFailedAction>(fetchResultsFailedAction)
]);

List<Result> fetchResultsSucceededReducer(
    List<Result> results, FetchResultsSucceededAction action) {
  return action.results;
}

List<Result> fetchResultsFailedAction(
    List<Result> results, FetchResultsFailedAction action) {
  //When I figure out how to make an object with an embedded result list work I wil change this...
  return [];
}

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveItemAction>(removeItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(removeItemsReducer),
  TypedReducer<List<Item>, LoadedItemsAction>(loadItemsReducer),
  TypedReducer<List<Item>, ItemCompletedAction>(itemCompletedReducer),
]);

List<Item> addItemReducer(List<Item> items, AddItemAction action) {
  return []
    ..addAll(items)
    ..add(Item(id: action.id, body: action.item));
}

List<Item> removeItemReducer(List<Item> items, RemoveItemAction action) {
  return List.unmodifiable(List.from(items)..remove(action.item));
}

List<Item> removeItemsReducer(List<Item> items, RemoveItemsAction action) {
  return [];
}

List<Item> loadItemsReducer(List<Item> items, LoadedItemsAction action) {
  return action.items;
}

List<Item> itemCompletedReducer(List<Item> items, ItemCompletedAction action) {
  return items
      .map((item) => item.id == action.item.id
          ? item.copyWith(completed: !item.completed)
          : item)
      .toList();
}
