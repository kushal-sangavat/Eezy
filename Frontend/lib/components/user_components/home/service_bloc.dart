import 'package:flutter/material.dart';
import 'dart:ui';

class ServiceBloc extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool gradiant ;
  final VoidCallback? onTap;

  const ServiceBloc({
    super.key
    , required this.title
    , required this.description
    , required this.icon,
    this.gradiant = false,
    this.onTap,
    });

  @override
  State<ServiceBloc> createState() => _ServiceBlocState();
}

class _ServiceBlocState extends State<ServiceBloc> {
  bool isHovered = false;


  @override
  Widget build(BuildContext context) {
    final textColor = widget.gradiant ? Colors.white : Colors.black87;
    final iconColor =
        isHovered ? Colors.white : (widget.gradiant ? Colors.white : const Color(0xFF0B1D59));
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),

      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(9),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            gradient: widget.gradiant
                      ? const LinearGradient(
                          colors: [Color.fromARGB(255, 3, 33, 85), Color.fromARGB(255, 10, 231, 128)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: widget.gradiant ? null : Colors.white,
            border: Border.all(
              color: const Color.fromARGB(255, 221, 221, 221),
              width: 2.0,
            ),
        
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              AnimatedScale(
                scale: isHovered ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isHovered
                            ? Colors.blue
                            : Colors.white.withOpacity(0.5),
                        // color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                            ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(widget.icon, size: 35, color: iconColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title, style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
        
                  ),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 140,
                    child: Text(widget.description, style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ), overflow: TextOverflow.ellipsis, maxLines: 2,),
                  ),
        
        
                const SizedBox(width: 200),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}