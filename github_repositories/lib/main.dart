import 'package:flutter/material.dart';
import 'package:github_repositories/screen/repositories/actions/repositories_action.dart';
import 'package:github_repositories/screen/repositories/coordinator/repositories_coordinator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return RepositoriesCoordinator(
                  context: context,
                  action: FetchRepositoriesAction(),
                  arguments: null)
              .start();
        },
      ),
    );
  }
}
