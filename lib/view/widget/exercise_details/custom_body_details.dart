
import 'package:flutter/material.dart';

class CustomBodyDetails extends StatelessWidget {
  const CustomBodyDetails({
    super.key, required this.title,
  });
 final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.symmetric(vertical: 6),
       decoration: BoxDecoration(
         color: const Color(0xFF1A1A2E),
         borderRadius: BorderRadius.circular(12),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.2),
             blurRadius: 4,
             offset: const Offset(0, 2),
           )
         ],
       ),
       child: ListTile(
         leading: const Icon(Icons.fitness_center,
             color: Colors.pinkAccent),
         title: Text(
          title,
           style: const TextStyle(
               color: Colors.white70, fontSize: 14, height: 1.4),
         ),
       ),
     );
  }
}
