import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/screen_route.dart';
import 'package:flutter_recipe_proto_app/logic/app_state_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  // SplashScreen MaterialPage Helper
  static MaterialPage page() {
    return MaterialPage(
        name: FoodRecipeAppPages.splashPath,
        key: ValueKey(FoodRecipeAppPages.accountPath),
        child: SplashScreen());
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/app_assets/app_logo.png'),
            ),
            const Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
