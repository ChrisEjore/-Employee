import 'package:flutter/material.dart';
import '../models/employee.dart';
import 'confirmation_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final String username;
  const RegistrationScreen({super.key, required this.username});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Field Controllers
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _natIdController = TextEditingController();
  final _deptController = TextEditingController();
  final _posController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  // Dropdowns/Pickers States
  String _selectedGender = 'Male';
  String _selectedEmpType = 'Permanent';
  DateTime? _selectedDate;

  final List<String> _genders = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
  final List<String> _empTypes = ['Permanent', 'Contract', 'Internship'];

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _natIdController.dispose();
    _deptController.dispose();
    _posController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _idController.clear();
    _nameController.clear();
    _natIdController.clear();
    _deptController.clear();
    _posController.clear();
    _phoneController.clear();
    _emailController.clear();
    _addressController.clear();
    setState(() {
      _selectedGender = 'Male';
      _selectedEmpType = 'Permanent';
      _selectedDate = null;
    });
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newEmployee = Employee(
        id: _idController.text.trim(),
        fullName: _nameController.text.trim(),
        nationalId: _natIdController.text.trim(),
        gender: _selectedGender,
        department: _deptController.text.trim(),
        position: _posController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        dob: _selectedDate,
        employmentType: _selectedEmpType,
        address: _addressController.text.trim(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(employee: newEmployee, username: widget.username),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Employee'),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Employee ID *', prefixIcon: Icon(Icons.badge)),
                validator: (val) => val == null || val.trim().isEmpty ? 'Employee ID cannot be empty' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name *', prefixIcon: Icon(Icons.person)),
                validator: (val) => val == null || val.isEmpty ? 'Full Name is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _natIdController,
                decoration: const InputDecoration(labelText: 'National ID Number *', prefixIcon: Icon(Icons.card_membership)),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'National ID required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Gender', prefixIcon: Icon(Icons.wc)),
                items: _genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => setState(() => _selectedGender = val!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _deptController,
                decoration: const InputDecoration(labelText: 'Department *', prefixIcon: Icon(Icons.business)),
                validator: (val) => val == null || val.isEmpty ? 'Department is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _posController,
                decoration: const InputDecoration(labelText: 'Job Position *', prefixIcon: Icon(Icons.work)),
                validator: (val) => val == null || val.isEmpty ? 'Position is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number *', prefixIcon: Icon(Icons.phone)),
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Phone number required';
                  if (!RegExp(r'^\d+$').hasMatch(val)) return 'Must contain digits only';
                  if (val.length < 9 || val.length > 15) return 'Invalid phone length (9-15 digits)';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Address *', prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Email is required';
                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) return 'Invalid email address';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(_selectedDate == null ? 'Select Date of Birth' : 'DOB: ${_selectedDate!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today, color: colorScheme.primary),
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[400]!), borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.grey[50],
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedEmpType,
                decoration: const InputDecoration(labelText: 'Employment Type', prefixIcon: Icon(Icons.assignment_ind)),
                items: _empTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (val) => setState(() => _selectedEmpType = val!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Residential Address *', prefixIcon: Icon(Icons.home)),
                maxLines: 2,
                validator: (val) => val == null || val.isEmpty ? 'Address is required' : null,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clearForm,
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}