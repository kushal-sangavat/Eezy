// import 'package:flutter/material.dart';

// class AnnouncementCard extends StatefulWidget {
//   final String title;
//   final String subtitle;
//   final String description;
//   final String date;
//   final String category;

//   const AnnouncementCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//     required this.date,
//     required this.category,
//   });

//   @override
//   State<AnnouncementCard> createState() => _AnnouncementCardState();
// }

// class _AnnouncementCardState extends State<AnnouncementCard> {
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => setState(() => _isExpanded = !_isExpanded),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade300,
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header (always visible)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(widget.title,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold)),
//                 Icon(
//                   _isExpanded
//                       ? Icons.keyboard_arrow_up
//                       : Icons.keyboard_arrow_down,
//                   color: Colors.grey,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(widget.subtitle,
//                 style: const TextStyle(color: Colors.grey, fontSize: 13)),
//             Text(widget.date,
//                 style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),

//             // Expandable section
//             if (_isExpanded) ...[
//               const SizedBox(height: 12),
//               Text(widget.description,
//                   style: const TextStyle(fontSize: 14, height: 1.4)),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';

class AnnouncementCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final String date; // e.g. "2024-01-15"
  final String time; // e.g. "10:00 AM"
  final String category; // e.g. "Event"
  final String priority; // e.g. "high"
  final IconData icon;

  const AnnouncementCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.priority,
    this.icon = Icons.emoji_events_outlined, // default trophy icon
  });

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  bool _isExpanded = false;

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return Colors.red;
      case "medium":
        return Colors.orange;
      case "low":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon + tags + dropdown icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Box
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.icon, color: Colors.indigo, size: 28),
                ),
                const SizedBox(width: 12),

                // Title + Tags
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Category tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.category,
                              style: TextStyle(
                                  color: Colors.purple.shade700, fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 6),
                          // Priority tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(widget.priority)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.priority,
                              style: TextStyle(
                                color: _getPriorityColor(widget.priority),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Title
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                // Expand icon
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Subtitle + Date/Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                      fontSize: 13, color: Colors.blueGrey, height: 1.4),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.date,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.blueGrey)),
                    Text("at ${widget.time}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.blueGrey)),
                  ],
                ),
              ],
            ),

            // Expanded Description
            if (_isExpanded) ...[
              const SizedBox(height: 12),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
