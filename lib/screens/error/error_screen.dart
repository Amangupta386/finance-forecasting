import 'package:ddofinance/utils/constants/images.dart';
import 'package:ddofinance/widgets/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: ImageAsset(
            imageName: Images.walkingtreeLogo, width: deviceWidth / 25),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error...........!',
                style: TextStyle(
                  fontSize: 23,
                )),
            TextButton(
                onPressed: () {
                  context.go('/');
                },
                child: const Text('Back to Home'))
          ],
        ),
      ),
    ));
  }
}
