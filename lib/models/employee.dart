class Employee {
  final String id;
  final String fullName;
  final String nationalId;
  final String gender;
  final String department;
  final String position;
  final String phone;
  final String email;
  final DateTime? dob;
  final String employmentType;
  final String address;

  Employee({
    required this.id,
    required this.fullName,
    required this.nationalId,
    required this.gender,
    required this.department,
    required this.position,
    required this.phone,
    required this.email,
    this.dob,
    required this.employmentType,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'nationalId': nationalId,
      'gender': gender,
      'department': department,
      'position': position,
      'phone': phone,
      'email': email,
      'dob': dob?.toIso8601String(),
      'employmentType': employmentType,
      'address': address,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      nationalId: map['nationalId'] ?? '',
      gender: map['gender'] ?? '',
      department: map['department'] ?? '',
      position: map['position'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      dob: map['dob'] != null ? DateTime.parse(map['dob']) : null,
      employmentType: map['employmentType'] ?? '',
      address: map['address'] ?? '',
    );
  }
}