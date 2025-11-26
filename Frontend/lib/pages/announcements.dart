import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jklu_eezy/components/header/header.dart';
import 'package:jklu_eezy/components/user_components/announcements/block.dart';
import 'package:jklu_eezy/components/admin_components/announcment.dart';
import 'package:jklu_eezy/apicall/auth_utils.dart';
import 'package:jklu_eezy/components/storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Announcements extends StatefulWidget {
  final bool isAdmin;
  const Announcements({super.key, this.isAdmin = false});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  bool isAdmin = false;
  bool isLoading = true;
  List announcements = [];

  final categoryController = TextEditingController();
  final priorityController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSetup();
  }

  Future<void> initSetup() async {
    try {
      bool adminStatus = await checkAdminStatus();
      setState(() => isAdmin = adminStatus);
      await fetchAnnouncements();
    } catch (e) {
      print("Error in initSetup: $e");
    }
  }

  Future<void> fetchAnnouncements() async {
    try {
      setState(() => isLoading = true);
      // String baseUrl = Platform.isAndroid
      //     ? "${dotenv.env['PROD_BACKEND_URL']}"
      //     : "${dotenv.env['BACKEND_URL']}";
      String baseUrl = "${dotenv.env['BACKEND_URL']}";
      final token = await getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/home/getannouncements'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          announcements = data ?? [];
          isLoading = false;
        });
      } else {
        print("Failed to load announcements: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching announcements: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(249, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // final isSmallScreen = constraints.maxWidth < 400;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Back & Add Announcement Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const BackButton(
                                color: Color.fromARGB(255, 3, 59, 105),
                              ),
                              Flexible(
                                child: Text(
                                  'Back to Dashboard',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 3, 59, 105),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              if (isAdmin)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Announcement(),
                                        ),
                                      ).then((_) => fetchAnnouncements());
                                    },
                                    icon: const Icon(Icons.add, color: Colors.white),
                                    label: const Text(
                                      'Add Announcement',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 3, 59, 105),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // 🔹 Heading
                          const Text(
                            'Announcements',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Stay updated with latest campus news',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 🔹 Announcement List
                          if (isLoading)
                            const Center(child: CircularProgressIndicator())
                          else if (announcements.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text(
                                  "No announcements available",
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            )
                          else
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: announcements.length,
                              itemBuilder: (context, index) {
                                final ann = announcements[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: AnnouncementCard(
                                    title: ann['Title'] ?? 'Untitled',
                                    subtitle: ann['Subtitle'] ?? 'General',
                                    description: ann['Description'] ?? '',
                                    date: ann['date'] ?? '',
                                    time: ann['time'] ?? '',
                                    category: ann['Category'] ?? 'General',
                                    priority: ann['priority'] ?? 'low',
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
