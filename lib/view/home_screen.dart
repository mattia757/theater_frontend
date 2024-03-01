import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model_view/home_view_model.dart';
import '../model_view/user_view_model.dart';
import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              final userViewModel = Provider.of<UserViewModel>(context, listen: false);
              userViewModel.removeUser();
              Navigator.pushNamed(context, RoutesName.login);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => _homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            return Center(
              child: Text('Home Screen'),
            );
          },
        ),
      ),
    );
  }
}
