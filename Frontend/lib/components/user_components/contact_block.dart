import 'package:flutter/material.dart';

class ContactBlock extends StatefulWidget {
    final String role;
    final String name;
    final String position;
    final String department;
    final String phone;
    final String email;
    final String location;
  
  ContactBlock({
    super.key,
    required this.role,
    required this.name,
    required this.position,
    required this.department,
    required this.phone,
    required this.email,
    required this.location,
    });

    

    static const Map<String, Color> roleColors = {
      "faculty": Color.fromARGB(255, 221, 220, 220),
    "admin": Color.fromARGB(255, 158, 205, 243),
    "health": Color.fromARGB(255, 139, 239, 142),
    "mess": Color.fromARGB(255, 233, 162, 246),
    'security': Color.fromARGB(255, 255, 206, 84),
    'lrc': Color.fromARGB(255, 255, 206, 84),
    'hostel': Color.fromARGB(255, 255, 206, 84),
    'staff': Color.fromARGB(255, 149, 246, 230),
    };

  @override
  State<ContactBlock> createState() => _ContactBlockState();
  
}

class _ContactBlockState extends State<ContactBlock> {
  @override
  Widget build(BuildContext context) {

    final roleColor = ContactBlock.roleColors[widget.role.toLowerCase()] ?? Colors.black;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
      
                        Text(
                          widget.position,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 2),
      
                        Text(
                          widget.department,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
      
                      color: roleColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Text(
                      widget.role,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
      
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.phone_outlined, size: 18,color: Colors.black87,),
                  const SizedBox(width: 5,),
                  Text(widget.phone, style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.mail_outline, size: 18, color: Colors.black87,),
                  const SizedBox(width: 5,),
                  Text(widget.email, style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_pin, size: 18, color: Colors.black87,),
                  const SizedBox(width: 5,),
                  Text(widget.location, style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  ),
                ],
              ),
      
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        // Call action
                      },
                      icon: Icon(Icons.phone_outlined, color: Colors.black87),
                      label: Text(
                        "Call",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Spacer(),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Call action
                      },
                      icon: Icon(Icons.mail_outline, color: Colors.black87),
                      label: Text(
                        "Email",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
      
            ],
          ),      
          ),
      ),
    );
  }
}