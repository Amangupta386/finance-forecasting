// import 'package:ddofinance/routing/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class WebButtonDisable extends StatelessWidget {
//   const WebButtonDisable({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return InAppWebView(
//       initialUrlRequest: URLRequest(url: Uri.parse(Routes.initialScreen)),
//       initialOptions: InAppWebViewGroupOptions(
//         crossPlatform: InAppWebViewOptions(
//           javaScriptEnabled: true,
//         ),
//       ),
//       onWebViewCreated: (InAppWebViewController controller) {
//         // Inject JavaScript to handle backward navigation and disable forward button
//         controller.evaluateJavascript(source: '''
//       window.onpopstate = function(event) {
//         // Handle backward navigation here
//         console.log("Backward navigation attempted");
//       };
//       window.history.forward = function() {
//         // Override forward button behavior
//         console.log("Forward button disabled");
//       };
//     ''');
//       },
//     )
//     ;
//   }
// }
//
//
