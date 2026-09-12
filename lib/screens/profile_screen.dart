import 'package:flutter/material.dart';
import '../models/employee.dart';
import 'dashboard_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Employee employee;
  final String username;

  const ProfileScreen({super.key, required this.employee, required this.username});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: colorScheme.primary,
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(employee.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(employee.position, style: TextStyle(fontSize: 16, color: Colors.grey[600], fontStyle: FontStyle.italic)),
            const Divider(height: 32, thickness: 1),
            _buildProfileTile(context, Icons.badge, 'Employee ID', employee.id),
            _buildProfileTile(context, Icons.fingerprint, 'National ID', employee.nationalId),
            _buildProfileTile(context, Icons.wc, 'Gender', employee.gender),
            _buildProfileTile(context, Icons.business, 'Department', employee.department),
            _buildProfileTile(context, Icons.phone, 'Phone Number', employee.phone),
            _buildProfileTile(context, Icons.email, 'Email Address', employee.email),
            _buildProfileTile(context, Icons.cake, 'Date of Birth', employee.dob != null ? '${employee.dob!}'.split(' ')[0] : 'Not provided'),
            _buildProfileTile(context, Icons.work_outline, 'Employment Type', employee.employmentType),
            _buildProfileTile(context, Icons.location_on, 'Residential Address', employee.address),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate back cleanly and wire the state to the fresh state engine
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(username: username, registeredEmployee: employee),
                        ),
                            (route) => false,
                      );
                    },
                    icon: const Icon(Icons.dashboard),
                    label: const Text('Dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}