import 'package:flutter/material.dart';

class TryOut extends StatelessWidget {
  const TryOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Icon(Icons.add_home_work),
            TextField(
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
            TextField(),
            TextButton(onPressed: null, child: Text("Sign In")),
          ],
        ),
      ),
    );
  }
}
