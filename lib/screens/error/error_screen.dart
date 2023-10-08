import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Error...........!',
                style: TextStyle(fontSize: 23,) ),
              TextButton(onPressed: (){
                context.go('/');
              },
                  child: const Text('Back to Home'))
            ],
          ),),
        )
    );
  }
}
