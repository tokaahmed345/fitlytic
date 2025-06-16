
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/custom_colors.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red[100],
      alignment: AlignmentDirectional.centerStart,
      // height: 150.0,
      child: ListTile(
        leading: Container(
          width: 60,
          height: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: MyColors.secBlue),
          child: Image.asset(
            "assets/notifications/man.png",
          ),
        ),
        title: const Text(
          "Amir Mohamed",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          "Lose a Fat Program",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: MaterialButton(
          textColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          color: MyColors.primaryBlue,
          onPressed: () {},
          child: const Text("Edit"),
        ),
      ),
    );
  }
}
