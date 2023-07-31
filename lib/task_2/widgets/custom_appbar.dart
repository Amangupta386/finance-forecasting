import 'package:flutter/material.dart';
import '../util/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:  BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 5, color: Theme.of(context).primaryColor)),
        ),
        child: AppBar(
          title: RichText(
            text:  TextSpan(
              text: 'Welcome ',
              style: Theme.of(context).textTheme.titleMedium,
              children: <TextSpan>[
                const TextSpan(text: 'back '),
                TextSpan(
                  text: 'Admin!',
                  style:Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
          ),
          actions:   [
            Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: kRed,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Logout',
                  style:Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 21,
                )
              ],
            )
          ],
        ));
  }
}