import 'package:redux/redux.dart';
import 'package:redux_items/model/model.dart';
import 'package:redux_items/model/result.dart';
import 'package:redux_items/redux/actions.dart';

class ViewModel {
  final List<Result> results;
  final List<Item> items;
  final Function(String) onDoSearch;
  final Function(Item) onCompleted;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  ViewModel({
    this.results,
    this.items,
    this.onCompleted,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveItems,
    this.onDoSearch,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onAddItem(String body) {
      store.dispatch(AddItemAction(body));
      store.dispatch(FetchResultsAction(body));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction());
    }

    _onCompleted(Item item) {
      store.dispatch(ItemCompletedAction(item));
    }

    // Add stuff in heare when we have actions to dispatch
    _onDoSearch(String query) {
      store.dispatch(FetchResultsAction(query));
    }

    return ViewModel(
      results: store.state.results,
      items: store.state.items,
      onCompleted: _onCompleted,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
      onDoSearch: _onDoSearch,
    );
  }
}
