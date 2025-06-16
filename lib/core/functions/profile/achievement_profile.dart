
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';

Widget buildHeader(void Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
          hoverColor: AppColor.grey2,
          iconSize: 24.0,
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),

          const Text(
            "Achievements",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "View All",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildAchievementCard({
  //   required IconData icon,
  //   required Color iconColor,
  //   required String title,
  //   required String subtitle,
  //   required double progress,
  //   required Color progressColor,
  //   required String date,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF212936),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //               color: iconColor.withOpacity(0.1),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Icon(
  //               icon,
  //               color: iconColor,
  //               size: 24,
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           Text(
  //             title,
  //             style: const TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //           ),
  //           const SizedBox(height: 4),
  //           Text(
  //             subtitle,
  //             style: TextStyle(
  //               fontSize: 12,
  //               color: Colors.white.withOpacity(0.7),
  //             ),
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //           const SizedBox(height: 16),
  //           const Spacer(),
  //           LinearProgressIndicator(
  //             value: progress,
  //             backgroundColor: Colors.grey[800],
  //             valueColor: AlwaysStoppedAnimation<Color>(progressColor),
  //           ),
  //           const SizedBox(height: 8),
  //           Text(
  //             date,
  //             style: TextStyle(
  //               fontSize: 12,
  //               color: Colors.white.withOpacity(0.5),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }