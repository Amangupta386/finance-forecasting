import 'package:ddofinance/providers/authentication/auth_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:provider/provider.dart';

/// A custom Flutter widget that represents an AppBar with additional functionality.
///
/// This custom AppBar includes a title, a logout action button, and the ability to display a top snackbar.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorTheme = theme.colorScheme;
    final provider = Provider.of<AuthProvider>(context);
    return AppBar(
      elevation: 4,
      key: const Key('common_appbar'),
      automaticallyImplyLeading: false,
      // Title with rich text combining two text spans.
      title: RichText(
        text: TextSpan(
          text: Labels.welcomeBack,
          style: textTheme.titleMedium,
          children: <TextSpan>[
            TextSpan(
              text: Labels.admin,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),
      ),
      actions: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            key: const Key('logout_button'),
            onTap: provider.onLogOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  MaterialIcons.logOut,
                  color: colorTheme.error,
                  size: Sizes.s20,
                ),
                Text(
                  Labels.logout,
                  style: textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold, color: colorTheme.error),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
