import 'package:ddofinance/providers/authentication/auth_provider.dart';
import 'package:ddofinance/utils/common_methods.dart';
import 'package:ddofinance/utils/constants/images.dart';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/widgets/image_asset.dart';
import 'package:provider/provider.dart';

/// A widget representing a login form.
class LoginForm extends StatefulWidget {
  /// Constructs a [LoginForm] with a callback function [onSigned].
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode formFocusNode = FocusNode();
  // bool isLoading = false;

  @override
  void initState() {
    formFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    formFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context)
        .size
        .height; //It's used to measure the size of the screen.
    final bool isLargeScreen = DeviceScreen.isLargeScreen(
        context); //It's used to check the whether the screen size is less than or equal to 1600 or not.
    final bool isAndroid =
        DeviceOS.isAndroid; // It's used to check the type of the device.
    return Container(
      padding: EdgeInsets.all(Insets.s24),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 7,
              spreadRadius: 0.4,
              color: theme.colorScheme.background)
        ],
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s12)),
      ),
      constraints: BoxConstraints.tightFor(
          //According to screen size, it's going to give responsive constraints to the form.
          width: (isLargeScreen) ? deviceWidth / 5 : deviceWidth / 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ImageAsset(
                imageName: Images.wttLogoWithName,
                width: (isLargeScreen)
                    ? deviceWidth / 10
                    : deviceWidth / 4, //It's checking for the responsive Image.
              ),
            ],
          ),
          SizedBox(
            height: Sizes.s24,
          ),
          Text(Labels.login,
              //According to the device type, it's going to configure the theme properties.
              style: theme.textTheme.titleLarge),
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            Labels.loginMessage,
            style: theme.textTheme.labelMedium!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          SizedBox(
            height: Sizes.s20,
          ),
          Consumer<AuthProvider>(builder: (context, authProvider, child) {
            return Form(
                key: _formKey,
                child: Focus(
                  onKey: CommonMethods.changeFormFieldFocus,
                  focusNode: formFocusNode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Labels.email,
                        style: (isAndroid)
                            ? theme.textTheme.labelMedium!.copyWith(
                                fontSize: FontSizes.s10, color: Colors.black)
                            : theme.textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: Sizes.s08,
                      ),
                      //Below code is for email textfield.
                      TextFormField(
                          key: const Key('email'),
                          controller: authProvider.loginControllers.email,
                          keyboardType: TextInputType.name,
                          style: theme.textTheme.bodySmall,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            return Validators.validateUsername(value!);
                            // return Validators.emailValidation(value!);
                          }),
                      SizedBox(
                        height: Sizes.s14,
                      ),
                      Text(
                        Labels.password,
                        style: (isAndroid)
                            ? theme.textTheme.labelMedium!.copyWith(
                                fontSize: FontSizes.s10, color: Colors.black)
                            : theme.textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: Sizes.s08,
                      ),
                      //Below code is for password textfield.
                      TextFormField(
                        key: const Key('password'),
                        controller: authProvider.loginControllers.password,
                        keyboardType: TextInputType.number,
                        obscuringCharacter: '*',
                        obscureText: authProvider.toggle,
                        style: theme.textTheme.bodySmall,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: authProvider.onToggle,
                              icon: (authProvider.toggle)
                                  ? Icon(
                                      MaterialIcons.visibilityOff,
                                      color: Colors.grey,
                                      size: (isLargeScreen)
                                          ? deviceWidth / 90
                                          : deviceWidth / 40,
                                    )
                                  : Icon(
                                      MaterialIcons.visibility,
                                      color: Colors.grey,
                                      size: (isLargeScreen)
                                          ? deviceWidth / 90
                                          : deviceWidth / 40,
                                    )),
                          contentPadding: EdgeInsets.all(Insets.s12),
                        ),
                        onEditingComplete: () {
                          authProvider.onCLickLogin(_formKey);
                        },
                        validator: (value) {
                          return Validators.passwordValidation(value!);
                        },
                      ),
                      SizedBox(
                        height: Sizes.s28,
                      ),
                      SizedBox(
                        height: deviceHeight / 16.14,
                        width: double.infinity,
                        child: ElevatedButton(
                          key: const Key('signIn'),
                          onPressed: () async {
                            authProvider.onCLickLogin(_formKey);
                          },
                          child: (authProvider.isLoading)
                              ? SizedBox(
                                  height: Sizes.s20,
                                  width: Sizes.s20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: theme.colorScheme.secondary,
                                  ),
                                )
                              : const Text(Labels.login),
                        ),
                      ),
                    ],
                  ),
                ));
          }),
        ],
      ),
    );
  }
}
