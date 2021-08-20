import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/screen_route.dart';

import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: FoodRecipeAppPages.raywenderlich,
        key: ValueKey(FoodRecipeAppPages.raywenderlich),
        child: const WebViewScreen());
  }

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('raywenderlich.com'),
      ),
      body: const WebView(
        initialUrl: 'https://www.raywenderlich.com/',
      ),
    );
  }
}
