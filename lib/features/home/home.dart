import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 20,
              ),
              child: Row(
                children: [
                  Text(
                    'My ',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text('Home', style: TextStyle(fontSize: 28)),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection('test').add({
                        'createdAt': FieldValue.serverTimestamp(),
                        'msg': 'hello from hygia',
                      });
                    },
                    child: const Text('Test Firestore Write'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
