import 'package:flutter/material.dart';

class QrPage extends StatelessWidget {
  const QrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('QR'),
      ),
      body: const Center(child: Text('This is the QR Page')),
    );
  }
}
