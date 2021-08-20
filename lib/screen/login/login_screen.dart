import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/screen_route.dart';
import 'package:flutter_recipe_proto_app/logic/app_state_manager.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
    this.username,
  }) : super(key: key);
  final String? username;

  final Color appColor = const Color.fromRGBO(255, 196, 1, 1);
  final TextStyle focusedStyle = const TextStyle(color: Colors.black);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  static MaterialPage page() {
    return MaterialPage(
      name: FoodRecipeAppPages.loginPath,
      key: ValueKey(FoodRecipeAppPages.loginPath),
      child: const LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
                child: Image(
                  image: AssetImage(
                    'assets/app_assets/app_logo.png',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildTextfield(username ?? 'Username'),
              const SizedBox(height: 16),
              buildTextfield('Password'),
              const SizedBox(height: 16),
              buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: appColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          Provider.of<AppStateManager>(context, listen: false)
              .login('mocUsername', 'mockPassword');
        },
      ),
    );
  }

  Widget buildTextfield(String hintText) {
    return TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }
}
