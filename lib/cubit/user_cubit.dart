import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mini/obj.dart';
import 'package:mini/repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> with Endpoints {
  UserCubit() : super(UserInitial());

  void refetch() async {
    emit(UserLoading());

    await new Future.delayed(const Duration(seconds: 2));

    try {
      ObjHolder res = await profile();
      ProfileResponse response = ProfileResponse.fromJson(res.response);

      emit(UserFetched(profile: response.data));
    } on Exception catch (e) {
      print(e);
      emit(UserInitial());
    }
  }

  void reset() async {
    emit(UserInitial());
  }
}
