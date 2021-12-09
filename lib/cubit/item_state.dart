part of 'item_cubit.dart';

@immutable
abstract class ItemState extends Equatable {
  final List<Item> items;

  const ItemState(this.items);

  List<Object> get props => [items];
}

class ItemInitial extends ItemState {
  ItemInitial(item) : super([]);
}

class ItemLoading extends ItemState {
  ItemLoading(item) : super([]);
}

class ItemFetched extends ItemState {
  ItemFetched(item) : super(item);
}
