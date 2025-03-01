import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error Page"),
            Text("Maybe Check your console and fix your routes?"),
            Text("go_router, routes, Apptexts")
          ],
        ),
      ),
    );
  }
}
