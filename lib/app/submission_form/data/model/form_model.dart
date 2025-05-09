import 'dart:convert';

class FormModel {
  final String name;
  final String email;
  final String mobileNumber;
  final String serviceSelected;
  FormModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.serviceSelected,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'serviceSelected': serviceSelected,
    };
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      serviceSelected: map['serviceSelected'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromJson(String source) =>
      FormModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FormModel(name: $name, email: $email, mobileNumber: $mobileNumber, serviceSelected: $serviceSelected)';
  }
}
