import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model_view/home_view_model.dart';
import '../model_view/user_view_model.dart';
import '../utils/routes/routes_name.dart';
import 'get_users_screen.dart';

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
            onPressed: () async {
              final userViewModel = Provider.of<UserViewModel>(context, listen: false);
              try {
                await userViewModel.logout();
                // Usa `mounted` per verificare se il widget è ancora nell'albero dei widget.
                if (!mounted) return;
                // Se il widget è ancora montato, allora procedi con la navigazione.
                context.go(RoutesName.login);
              } catch (e) {
                // Anche qui, controlla se il widget è ancora montato prima di mostrare lo SnackBar.
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout failed')));
              }
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => _homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            // Mostra la vista getUsersScreen all'interno di HomeScreen
            return getUsersScreen();
          },
        ),
      ),
    );
  }
}
