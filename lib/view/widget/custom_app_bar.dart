
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/custom_colors.dart';
import 'package:flutter_application_depi/view/screen/Home/start_screen.dart';
import 'package:flutter_application_depi/view/screen/youtub_handing.dart';


class CustomAppBar extends StatelessWidget {
  bool isleadingicon;
  bool istrailingicon;
  String title;
  Color? textColor;
  CustomAppBar(
      {super.key,
      required this.isleadingicon,
      required this.istrailingicon,
      required this.title,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      isleadingicon
          ? IconButton(
              hoverColor: MyColors.grey2,
              iconSize: 24.0,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: MyColors.black,
              ),
            )
          : Container(),
      Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      istrailingicon
          ? GestureDetector(
            onTap: () {
              // Handle trailing icon tap action
              Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const VideoListPage(),
                    ),
                  );
            },
            child: Container(
              width: 60,
              height: 45,
              alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: MyColors.customGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:const Icon(
                    Icons.more_horiz,
                    color: MyColors.black,
                ),
              ),
          )
          : Container(),
    ]);
  }
}
