
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../header/header.dart';
import '../storage.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final roleController = TextEditingController();
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();

  bool isLoading = false;
  String? selectedRole;

  @override
  void dispose() {
    roleController.dispose();
    nameController.dispose();
    positionController.dispose();
    departmentController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<bool> addContact(Map<String, String> data) async {
    final baseUrl = "${dotenv.env['BACKEND_URL']}";
    final url = Uri.parse("$baseUrl/api/home/addcontact");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getToken()}',
        },
        body: json.encode(data),
      );

      print('API Response: ${response.body}');
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Error adding contact: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Row
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blueAccent),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Back to Contact Directory',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Title
                      const Center(
                        child: Text(
                          'Add New Contact',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Dropdown Role
                      _buildDropdown(),

                      const SizedBox(height: 20),
                      _buildTextField(nameController, 'Full Name', Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(positionController, 'Position / Title', Icons.work),
                      const SizedBox(height: 15),
                      _buildTextField(departmentController, 'Department / Group', Icons.business_center),
                      const SizedBox(height: 15),
                      _buildTextField(phoneController, 'Phone Number', Icons.phone, keyboard: TextInputType.phone),
                      const SizedBox(height: 15),
                      _buildTextField(emailController, 'Email Address', Icons.email, keyboard: TextInputType.emailAddress),
                      const SizedBox(height: 15),
                      _buildTextField(locationController, 'Office Location', Icons.location_on),
                      const SizedBox(height: 30),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                          ),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  setState(() => isLoading = true);

                                  final newContactData = {
                                    'role': roleController.text.trim(),
                                    'name': nameController.text.trim(),
                                    'position': positionController.text.trim(),
                                    'department': departmentController.text.trim(),
                                    'phone': phoneController.text.trim(),
                                    'email': emailController.text.trim(),
                                    'location': locationController.text.trim(),
                                  };

                                  final success = await addContact(newContactData);
                                  setState(() => isLoading = false);

                                  if (success && mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Contact added successfully!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Failed to add contact.'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                },
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: Text(
                            isLoading ? 'Saving...' : 'Save Contact',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown with styling
  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      onChanged: (value) {
        setState(() {
          selectedRole = value;
          roleController.text = value ?? '';
        });
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_tree, color: Colors.blueAccent),
        labelText: 'Select Role',
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'faculty', child: Text('Faculty')),
        DropdownMenuItem(value: 'health', child: Text('Health')),
        DropdownMenuItem(value: 'mess', child: Text('Mess')),
        DropdownMenuItem(value: 'admin', child: Text('Admin')),
        DropdownMenuItem(value: 'security', child: Text('Security')),
        DropdownMenuItem(value: 'hostel', child: Text('Hostel')),

      ],
    );
  }

  // Styled text fields
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        labelText: label,
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
