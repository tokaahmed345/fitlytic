
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/search/searchdelegte.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {

        showSearch(context: context, delegate: ExercisesSearch());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF222533),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search workouts',
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
