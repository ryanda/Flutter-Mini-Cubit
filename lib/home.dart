import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini/cubit/user_cubit.dart';
import 'package:mini/obj.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    this._fetchUser();
  }

  _fetchUser() async {
    context.read<UserCubit>().refetch();
  }

  Widget _userInfo() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) return CircularProgressIndicator();
        if (state is UserInitial) return Text("Empty User");

        if (state is UserFetched) {
          User user = state.profile;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user.firstName),
              Text(user.lastName),
              Text(user.email),
            ],
          );
        }

        return Text("Alternative state: " + state.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                this._fetchUser();
              },
              child: Text("fetch user!"),
            ),
            this._userInfo(),
          ],
        ),
      ),
    );
  }
}
