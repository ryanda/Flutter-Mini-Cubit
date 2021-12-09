import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mini/obj.dart';
import 'package:mini/repository.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> with Endpoints {
  ItemCubit() : super(ItemInitial([]));

  void refetch() async {
    emit(ItemLoading([]));

    try {
      ObjHolder res = await listData();
      ListResponse response = ListResponse.fromJson(res.response);

      emit(ItemFetched(response.data));
    } on Exception catch (e) {
      print(e);
      emit(ItemInitial([]));
    }
  }

  void reset() async {
    emit(ItemInitial([]));
  }
}
