import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/custom_colors.dart';



class TodayTarget extends StatelessWidget {
  const TodayTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Image.asset(
            "assets/Today_task.png",
            width: 500,
            fit: BoxFit.fill,
          ),
          const Positioned(
            top: 20,
            left: 30.0,
            child: Text(
              "Today Target",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
          Positioned(
              top: 10,
              left: MediaQuery.of(context).size.width * 0.63,
              child: MaterialButton(
                textColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: MyColors.primaryBlue,
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const TodayTargetPage(),
                  //   ),
                  // );
                },
                child: const Text("Check"),
              )),
        ],
    );
  }
}
