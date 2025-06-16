
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/controller/exercise_cubit.dart';
import 'package:flutter_application_depi/utils/constants/custom_colors.dart';
import 'package:flutter_application_depi/utils/constants/exercises/exercises_home_constant.dart';
import 'package:flutter_application_depi/view/screen/Home/exercises/exercises_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoryCard extends StatefulWidget {
  final WorkoutCategory category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the category-specific exercise screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseCategoryScreen(
              categoryTitle: widget.category.title,
            )
          )
        ).then((_){
          context.read<ExerciseCubit>().resetState();
        });
      },
      borderRadius: BorderRadius.circular(12), // Match container's border radius
      child: Container(
        decoration: BoxDecoration(
          gradient: MyColors.customGradient2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.category.color,
                  width: 2,
                ),
              ),
              child: Icon(
                widget.category.icon,
                color: widget.category.color,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.category.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}