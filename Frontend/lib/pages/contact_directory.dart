import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jklu_eezy/components/admin_components/add_contact.dart';
import 'package:jklu_eezy/components/storage.dart';
import 'package:jklu_eezy/components/user_components/contact_directory/contact_block.dart';
import '../components/header/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jklu_eezy/apicall/auth_utils.dart';


class ContactDirectory extends StatefulWidget {
  final bool isAdmin;
  const ContactDirectory({super.key, this.isAdmin = false});

  @override
  State<ContactDirectory> createState() => _ContactDirectoryState();
}

class _ContactDirectoryState extends State<ContactDirectory> {
  List contacts = [];
  bool isLoading = true;
  bool isAdmin = false; // Add this line

  @override
  void initState() {
    super.initState();
    initSetup();
  }

  Future<void> initSetup() async {
    try {
      // ✅ Check admin and fetch contacts
      bool adminStatus = await checkAdminStatus();
      print('Admin status from token: $adminStatus'); // Debug print
      
      // Get the token and decode it to check the payload
      final token = await getToken();
      if (token != null) {
        final payload = json.decode(
          utf8.decode(base64.decode(base64.normalize(token.split('.')[1]))),
        );
        print('Token payload in initSetup: $payload'); // Debug print
      }
      
      setState(() {
        isAdmin = adminStatus;
        print('Set isAdmin state to: $isAdmin'); // Debug print
      });
      
      await fetchContacts();
    } catch (e) {
      print('Error in initSetup: $e');
    }
  }

  Future<void> fetchContacts() async {
    try {
      print('Fetching contacts... Admin status: $isAdmin'); // Debug print
      String baseUrl = Platform.isAndroid ? "http://10.0.2.2:3000" : "http://localhost:3000";
      final token = await getToken();
      print('Token: $token'); // Debug print
      
      final response = await http.get(
        Uri.parse('$baseUrl/api/home/getcontact'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );


      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          contacts = data ?? [];
          isLoading = false;
        });
        print('Fetched ${contacts.length} contacts');
      } else {
        print("Failed to load contacts: ${response.statusCode}");
        setState(() {
          contacts = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching contacts: $e");
      setState(() {
        contacts = [];
        isLoading = false;
      });
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[50],
    body: Column(
      children: [
        Header(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  BackButton(color: const Color.fromARGB(255, 3, 59, 105)),
                  const SizedBox(width: 5),
                  Text(
                    'Back to Dashboard',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 3, 59, 105),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  if (isAdmin) // 👈 show button only for admin
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddContact()),
                        ).then((_) {
                          // 🔁 Refresh contact list when returning
                          fetchContacts();
                        });
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Add Contact',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 3, 59, 105),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Campus Directory',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Find contact information for faculty and staff',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SearchBar(
                  leading: const Icon(Icons.search, color: Colors.black54),
                  hintText: 'Search by name, department, or designation',
                  backgroundColor: MaterialStateProperty.all(Colors.grey[50]),
                  elevation: MaterialStateProperty.all(2.0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // ✅ Use Expanded with ListView, no SingleChildScrollView
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return ContactBlock(
                            role: contact['role'] ?? '',
                            name: contact['name'] ?? '',
                            position: contact['position'] ?? '',
                            department: contact['department'] ?? '',
                            phone: contact['phone'] ?? '',
                            email: contact['email'] ?? '',
                            location: contact['location'] ?? '',
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}