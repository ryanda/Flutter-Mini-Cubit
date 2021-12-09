import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini/cubit/item_cubit.dart';
import 'package:mini/cubit/user_cubit.dart';
import 'package:mini/home.dart';
import 'package:mini/http.dart';

void main() {
  networkInit();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<ItemCubit>(create: (context) => ItemCubit()),
      ],
      child: MaterialApp(
        title: 'Hello world',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
