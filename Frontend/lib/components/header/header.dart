
import 'package:flutter/material.dart';
// import 'package:jklu_eezy/pages/login.dart';
// import '../storage.dart';
import 'package:proj1/pages/home.dart';
// import '../../apicall/userdetails.dart';

class Header extends StatefulWidget {
  const Header({super.key,});

  @override
  State<Header> createState() => _HeaderState();
}



class _HeaderState extends State<Header> {
  String username ="";
  String email ="";
  

  // @override
  // void initState() {
  //   super.initState();
  //   _loadUser();
  // }

  // void _loadUser() async {
  //   final userDetails = await getUserDetails();
  //   if (userDetails != null) {
  //     setState(() {
  //       username = userDetails['name'] ?? 'No Name';
  //       email = userDetails['email'] ?? 'No Email';
  //     });
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 221, 221, 221),
            width: 1.0,
          ),

        ),
        child: Row(
          children: [



            const SizedBox(width: 30,),

            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()), // 👈 replace with your home widget
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 3, 66, 117),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'JK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'JKLU Eezy',
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 59, 105),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            IconButton(
              icon: const Icon(Icons.notifications_outlined, size: 20,),
              onPressed: () {
              },
            ),
            const SizedBox(width: 15),
            IconButton(
              icon: const Icon(Icons.person_2_outlined, size: 20,),
              onPressed: () async{
                // final userDetails = getUserDetails();
                // await UserService.instance.loadUser();

                // Now access the stored data
                // final username = UserService.instance.username;
                // final email = UserService.instance.email;

                showDialog(
                  context: context,
                  builder: (context) => ProfilePopup(
                    username: username.isNotEmpty ? username : 'No Name',
                    email: email.isNotEmpty ? email : 'No Email',
                  ),
                );
                  },
                ),
          ],
        
        ),
      ),
    );
  }
}


class ProfilePopup extends StatelessWidget {
  final String username;
  final String email;

  const ProfilePopup({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 15),
            Text(
              username,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 30),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(height: 30),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                // logout(); // call your secure storage logout function
                // Navigator.pushReplacement(
                //   // context,
                //   // MaterialPageRoute(builder: (context) => const LoginPage()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
