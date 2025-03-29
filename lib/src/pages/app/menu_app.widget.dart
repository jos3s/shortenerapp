import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/storage/secure_storage.dart';
import 'package:shortenerapp/src/shared/app_state.dart';

class MenuAppWidget extends StatelessWidget {
  final _secureStorage = SecureStorage();

  MenuAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return MenuAnchor(
      menuChildren: [
        FutureBuilder(
          future: _secureStorage.getToken(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MenuItemButton(
                leadingIcon: Icon(Icons.logout),
                child: Text('Logout'),
                onPressed: () {
                  state.logout();
                  _secureStorage.resetFields();
                  Navigator.of(context).pushReplacementNamed('/');
                },
              );
            } else {
              return MenuItemButton(
                leadingIcon: Icon(Icons.login),
                child: Text('Login'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              );
            }
          },
        ),
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }
}
