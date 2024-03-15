import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theater_frontend/repo/auth_repository.dart';

import '../data/response/api_responses.dart';
import '../model/user_model.dart';
import '../model_view/auth_view_model.dart';

class DeleteUserScreen extends StatefulWidget {
  const DeleteUserScreen({Key? key}) : super(key: key);

  @override
  State<DeleteUserScreen> createState() => _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {
  final AuthViewModel _authViewModel = AuthViewModel();
  late String? _selectedUserName;

  @override
  void initState() {
    //_authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _authViewModel.getUsersApi(context);
    _selectedUserName = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete User'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => _authViewModel,
        child: Column(
          children: [
            Consumer<AuthViewModel>(
              builder: (context, value, child) {
                if (value.usersList.data?.isEmpty ?? true) {
                  return Text('No users available');
                }

                return DropdownButton<String>(
                  items: value.usersList.data?.map((user) {
                    return DropdownMenuItem<String>(
                      value: user.username!,
                      child: Text(user.username!),
                    );
                  }).toList(),
                  onChanged: (String? selectedUserName) {
                    Future.microtask(() {
                      setState(() {
                        _selectedUserName = selectedUserName;
                      });
                    });
                  },
                  value: _selectedUserName,
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_selectedUserName != null) {
                  _showDeleteConfirmationDialog(_selectedUserName!);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Delete User',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        )
      );
  }

  void _showDeleteConfirmationDialog(String userName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete $userName?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                AuthRepository().deleteUser(context, _selectedUserName!);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
