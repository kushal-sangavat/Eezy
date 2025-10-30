// import 'package:flutter/material.dart';
// import 'package:jklu_eezy/components/header/header.dart';
// import '../components/user_components/announcements/block.dart';



// class Announcements extends StatelessWidget {
//   const Announcements({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(249, 255, 255, 255),
//       body: Column(
//         children: [
//           const Header(), // Fixed header at top
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               children: const [
//                 Text(
//                   'Announcements',
//                   style: TextStyle(
//                     fontSize: 35,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Stay updated with latest campus news',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Icon(Icons.pin_drop_outlined, color: Colors.black),
//                     SizedBox(width: 8),
//                     Text(
//                       'Pinned Announcements',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 AnnouncementCard(
//                   title: "Annual Tech Fest 2024 - Registration Open",
//                   subtitle: "Student Activities",
//                   description:
//                       "Get ready for the biggest tech event of the year! JKLU Tech Fest 2024 is here with exciting competitions, workshops, and prizes worth ₹5 lakhs. Register now at techfest.jklu.edu.in. Early bird registration ends on January 20th.",
//                   date: "2024-01-15",
//                   time: "10:00 AM",
//                   category: "Event",
//                   priority: "high",
//                 ),
//                 SizedBox(height: 15),
//                 AnnouncementCard(
//                   title: "Campus Wi-Fi Maintenance Scheduled",
//                   subtitle: "IT Services",
//                   description:
//                       "Please note that the campus Wi-Fi will be undergoing maintenance on February 5th from 1:00 AM to 5:00 AM. During this time, internet access may be intermittent. We apologize for any inconvenience caused and appreciate your understanding.",
//                   date: "2024-02-01",
//                   time: "9:00 AM",
//                   category: "Maintenance",
//                   priority: "medium",
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   'Recent Announcements',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 AnnouncementCard(
//                   title: "Guest Lecture on AI and Machine Learning",
//                   subtitle: "Computer Science Department",
//                   description:
//                       "We are excited to announce a guest lecture by Dr. Anjali Mehta, a leading expert in AI and Machine Learning, on March 10th at 3:00 PM in the Main Auditorium. All students and faculty are encouraged to attend this insightful session.",
//                   date: "2024-03-01",
//                   time: "11:00 AM",
//                   category: "Lecture",
//                   priority: "low",
//                 ),
//                 SizedBox(height: 15),
//                 AnnouncementCard(
//                   title: "Library Hours Extended During Exam Week",
//                   subtitle: "Library Services",
//                   description:
//                       "To support our students during the exam period, the library will be extending its hours from March 15th to March 25th. The library will now be open from 8:00 AM to 12:00 AM. Make the most of this opportunity to prepare for your exams!",
//                   date: "2024-03-05",
//                   time: "10:00 AM",
//                   category: "Library",
//                   priority: "medium",
//                 ),
//                 SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }








import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:jklu_eezy/components/header/header.dart';
import 'package:jklu_eezy/components/user_components/announcements/block.dart';
import 'package:jklu_eezy/components/admin_components/announcment.dart';
import 'package:jklu_eezy/apicall/auth_utils.dart';
import 'package:jklu_eezy/components/storage.dart';

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
      String baseUrl = Platform.isAndroid ? "http://10.0.2.2:3000" : "http://localhost:3000";
      final token = await getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/home/getannouncements'), // 🔹 your backend endpoint
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
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const BackButton(color: Color.fromARGB(255, 3, 59, 105)),
                    const Text(
                      'Back to Dashboard',
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 59, 105),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                              MaterialPageRoute(builder: (context) => const Announcment()),
                            ).then((_) => fetchAnnouncements());
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Add Announcement',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[800],
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
                    'Announcements',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    'Stay updated with latest campus news',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // 🔹 Main Announcements List
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : announcements.isEmpty
                          ? const Center(child: Text("No announcements available"))
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: announcements.length,
                              itemBuilder: (context, index) {
                                final ann = announcements[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: AnnouncementCard(
                                    title: ann['title'] ?? 'Untitled',
                                    subtitle: ann['subtitle'] ?? 'General',
                                    description: ann['description'] ?? '',
                                    date: ann['date'] ?? '',
                                    time: ann['time'] ?? '',
                                    category: ann['category'] ?? 'General',
                                    priority: ann['priority'] ?? 'low',
                                  ),
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
