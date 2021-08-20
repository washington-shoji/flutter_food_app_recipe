import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/screen_route.dart';
import 'package:flutter_recipe_proto_app/logic/app_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: FoodRecipeAppPages.onboardingPath,
      key: ValueKey(FoodRecipeAppPages.onboardingPath),
      child: OnboardingScreen(),
    );
  }

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  final Color appColor = const Color.fromRGBO(255, 196, 1, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Getting ready'),
        leading: GestureDetector(
          child: const Icon(
            Icons.chevron_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: buildPages()),
            buildIndicator(),
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          child: const Text(
            'Skip',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false).onboarded();
          },
        ),
      ],
    );
  }

  Widget buildPages() {
    return PageView(
      controller: controller,
      children: [
        onboardPageView(const AssetImage('assets/app_assets/recommend_1.png'),
            '''Check out recommended recipes.'''),
        onboardPageView(const AssetImage('assets/app_assets/sheet_1.png'),
            '''See recipe ingredients.'''),
        onboardPageView(const AssetImage('assets/app_assets/list_1.png'),
            '''Create your own shopping list.'''),
      ],
    );
  }

  Widget onboardPageView(ImageProvider imageProvider, String text) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image(
                fit: BoxFit.fitWidth,
                image: imageProvider,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ]),
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: WormEffect(
        activeDotColor: appColor,
      ),
    );
  }
}
