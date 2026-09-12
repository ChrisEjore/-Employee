import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Application'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info_outline_rounded, size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            const Text('StaffHub App', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const Text('Version 1.0.0', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            const Card(
              elevation: 0,
              color: Color(0xFFF5F5F5),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Purpose:\nThis application serves as a simplified workflow prototype built to showcase form handling, validation architectures, runtime state passing, and multi-layered screen routing inside Flutter.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, height: 1.4),
                ),
              ),
            ),
            const Spacer(),
            const Text('Developer: Chris Ejore', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            const SizedBox(height: 4),
            const Text('© 2026 StaffHub Inc. All rights reserved.', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}