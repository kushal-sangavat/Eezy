import 'package:flutter/material.dart';
import 'package:jklu_eezy/components/header/header.dart';
import 'package:jklu_eezy/components/user_components/quick_action/block.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import '../components/user_components/quick_action/EmergencyCard.dart';


class QuickActions extends StatefulWidget {
  const QuickActions({super.key});

  @override
  State<QuickActions> createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActions> {
  bool showWardens = false; // 🔹 track dropdown expand/collapse

  // Reusable Contact Card for Wardens
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
        body:Column(
          children: [
        const Header(),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16.0),
                  child: ListView(
                    children: [
                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "Emergency contacts and essential services",
                        style: TextStyle(color: Colors.black),
                      ),
                      // Emergency Contacts Warning Box
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                              size: 28,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Emergency Contacts",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "For immediate assistance, call the numbers below. Available 24/7.",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                              
                      const SizedBox(height: 20),
                              
                      const Text(
                        "Emergency Services",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                              
                      // 🔹 Ambulance Card
                      buildEmergencyCard(
                        icon: Icons.favorite_border,
                        iconColor: Colors.white,
                        iconBgColor: Colors.red,
                        title: "Ambulance",
                        tag: "URGENT", // will show badge
                        subtitle: "Emergency medical services",
                        callText: "Call 108",
                        buttonColor: Colors.red,
                        onCall: () async {
                          final Uri dialUri = Uri.parse('tel:108');

                          try {
                            if (!await url_launcher.launchUrl(
                              dialUri,
                              mode: url_launcher.LaunchMode.externalApplication, // 👈 important for iOS
                            )) {
                              throw Exception('Could not launch dialer');
                            }
                          } catch (e) {
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Cannot open dialer: $e')),
                            );
                          }
                        },
                      ),
                              
                      const SizedBox(height: 16),
                              
                      // Head Guard Card
                      // buildEmergencyCard(
                      //   icon: Icons.shield_outlined,
                      //   iconColor: Colors.white,
                      //   iconBgColor: Colors.blue,
                      //   title: "Head Guard",
                      //   subtitle: "Campus security head",
                      //   personName: "Mr. Rajesh Singh",
                      //   callText: "Call +91 9876543201",
                      //   buttonColor: Colors.blue,
                      //   onCall: () {
                      //     // Add Head Guard call logic
                      //   },
                      // ),

                      buildRoleCard(
                        "Head Guard",
                        "Campus security head",
                        Icons.shield_outlined,
                        Colors.blue,
                      ),
                              
                      const SizedBox(height: 16),
                              
                      // 🔹 Fire Service Card
                      buildEmergencyCard(
                        icon: Icons.local_police_outlined,
                        iconColor: Colors.white,
                        iconBgColor: Colors.orange,
                        title: "Fire Service",
                        tag: "ALERT", // optional badge
                        subtitle: "Campus fire emergency team",
                        callText: "Call 101",
                        buttonColor: Colors.orange,
                        onCall: () async {
                          final Uri dialUri = Uri.parse('tel:101');

                          try {
                            if (!await url_launcher.launchUrl(
                              dialUri,
                              mode: url_launcher.LaunchMode.externalApplication, // 👈 important for iOS
                            )) {
                              throw Exception('Could not launch dialer');
                            }
                          } catch (e) {
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Cannot open dialer: $e')),
                            );
                          }
                        },
                      ),
                              
                      const SizedBox(height: 16),
                              
                      // 🔹 Wardens Card with Dropdown
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.groups_2_outlined,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              
                              const SizedBox(width: 12),
                              
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Wardens",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Contact Hostels and Campus Wardens",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "4 Available",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              
                              // 🔹 Dropdown Button
                              IconButton(
                                icon: Icon(
                                  showWardens
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showWardens = !showWardens;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                              
                      // 🔹 Contact cards shown when dropdown is expanded
                      if (showWardens)
                        Column(
                          children: [
                            buildWardenCard(
                              position: "BH1 Boys Warden",
                              location: "Block A",
                              availability: "24/7 Available",
                            ),

                            buildWardenCard(position: 'BH2 Boys Warden', location: 'Block B', availability: 'Day Shift',),
                            buildWardenCard(position: 'GH1 Girls Warden', location: 'Block C', availability: 'Night Shift',),
                            buildWardenCard(position: 'GH2 Girls Warden', location: 'Block D', availability: '24/7 Available',),






                            // buildContactCard(
                            //   name: "Jane Smith",
                            //   post: "Assistant Warden",
                            //   location: "Block B",
                            //   availability: "24/7 Available",
                            //   onCall: () {},
                            // ),
                            // buildContactCard(
                            //   name: "David Kumar",
                            //   post: "Warden",
                            //   location: "Block C",
                            //   availability: "Day Shift",
                            //   onCall: () {},
                            // ),
                            // buildContactCard(
                            //   name: "Priya Sharma",
                            //   post: "Deputy Warden",
                            //   location: "Block D",
                            //   availability: "Night Shift",
                            //   onCall: () {},
                            // ),
                            // buildContactCard(
                            //   name: "Arjun Mehta",
                            //   post: "Senior Warden",
                            //   location: "Block E",
                            //   availability: "24/7 Available",
                            //   onCall: () {},
                            // ),
                          ],
                        ),
                              
                      const SizedBox(height: 16),
                              
                      // 🔹 Instructions Box
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 17,
                          right: 17,
                          bottom: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Important Instructions",
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\u2022 For medical emergencies, call 108 immediately.\n'
                              '\u2022 Contact head guard for any security concerns.\n'
                              '\u2022 Wardens are available for any hostel-related issues.\n'
                              '\u2022 Keep emergency number saved in your phone.\n'
                              '\u2022 Report any suspicious activities to the authorities.',
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
            ),
          ],
        ),
    );
  }
}
