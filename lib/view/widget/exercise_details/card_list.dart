import 'package:flutter/material.dart';

class DetailsCardList extends StatelessWidget {
  const DetailsCardList({super.key, required this.icon, required this.color, required this.text});
final  IconData icon;
final  Color color;
final String text;
  @override
  Widget build(BuildContext context) {
  return Column(
      children:  [Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(icon, color: color),
                title: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),]
          
          );
  }
}