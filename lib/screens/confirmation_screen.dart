import 'package:flutter/material.dart';
import '../models/employee.dart';
import 'profile_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final Employee employee;
  final String username;

  const ConfirmationScreen({super.key, required this.employee, required this.username});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Details'),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.fact_check_outlined, size: 60, color: Colors.orange),
            const SizedBox(height: 12),
            const Text('Please verify the entered details before completing registration.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDataRow(context, 'Emp ID:', employee.id),
                    _buildDataRow(context, 'Full Name:', employee.fullName),
                    _buildDataRow(context, 'National ID:', employee.nationalId),
                    _buildDataRow(context, 'Gender:', employee.gender),
                    _buildDataRow(context, 'Department:', employee.department),
                    _buildDataRow(context, 'Position:', employee.position),
                    _buildDataRow(context, 'Phone:', employee.phone),
                    _buildDataRow(context, 'Email:', employee.email),
                    _buildDataRow(context, 'DOB:', employee.dob != null ? '${employee.dob!}'.split(' ')[0] : 'N/A'),
                    _buildDataRow(context, 'Type:', employee.employmentType),
                    _buildDataRow(context, 'Address:', employee.address),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(employee: employee, username: username),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Confirm & Create Profile', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}