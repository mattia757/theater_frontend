import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theater_frontend/model_view/auth_view_model.dart';

import '../data/response/status.dart';
import '../model_view/user_view_model.dart';
import '../utils/routes/routes_name.dart';

class getUsersScreen extends StatefulWidget {
  const getUsersScreen({Key? key}) : super(key: key);

  @override
  State<getUsersScreen> createState() => _getUsersScreenState();
}

class _getUsersScreenState extends State<getUsersScreen> {
  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  void initState() {
    _authViewModel.getUsersApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed:() {
                final userViewModel = Provider.of<UserViewModel>(context, listen: false);
                userViewModel.removeUser();
                Navigator.pushNamed(context, RoutesName.login);
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
          title: const Text('List Users Screen'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => _authViewModel,
          child: Consumer<AuthViewModel>(
            builder: (context, value, child) {
              switch (value.usersList.status) {
                case Status.loading:
                  return const CircularProgressIndicator();
                case Status.error:
                  return Text(value.usersList.message.toString());
                case Status.completed:
                  return ListView.builder(
                    //itemCount: value.usersList!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                const Text('Name'),
                                Text(value.usersList.data![index].name.toString()),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('Surname'),
                                Text(value.usersList.data![index].surname.toString()),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('Email'),
                                Text(value.usersList.data![index].email.toString()),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('Username'),
                                Text(value.usersList.data![index].username.toString()),
                              ],
                            ),
                          ],
                        ),
                      );
                    },);
                default:
                  return const Text('Nothing to show');
              }
            },
          ),)
    );
  }
}