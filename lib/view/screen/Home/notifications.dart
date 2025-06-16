import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/custom_colors.dart';
import 'package:flutter_application_depi/utils/constants/notifications_list.dart';
import 'package:flutter_application_depi/view/widget/custom_app_bar.dart';
class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomAppBar(isleadingicon: true, istrailingicon: true, title: "Notifications",)),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
            itemCount: notifications_list.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  ListTile(
                    // onTap: () {},
                    leading: CircleAvatar(
                      maxRadius: 50.0,
                      backgroundColor:
                          (i % 2 == 0) ? MyColors.secBlue : MyColors.secPurple,
                      child: Image.asset(
                        notifications_list[i]["image"],
                        height: 30.0,
                      ),
                    ),
                    title: Text(notifications_list[i]["title"]),
                    subtitle: Text(notifications_list[i]["date"]),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                  i != (notifications_list.length - 1)
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const Divider(
                            thickness: 1,
                          ),
                        )
                      : Container()
                ],
              );
            }),
      ),
    );
  }
}
