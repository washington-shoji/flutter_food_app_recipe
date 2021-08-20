import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/data_model/user.dart';

class ProfileManager extends ChangeNotifier {
  AppUser get getUser => AppUser(
        firstName: 'Mr. Smoothie',
        lastName: 'Connoisseur',
        role: 'Flutterista',
        profileImageUrl: 'assets/profile_pics/person_male_avatar.png',
        points: 100,
        darkMode: _darkMode,
      );

  bool get didSelectUser => _didSelectUser;
  bool get didTapOnRaywenderlich => _tapOnUrl;
  bool get darkMode => _darkMode;

  var _didSelectUser = false;
  var _tapOnUrl = false;
  var _darkMode = false;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnUrl(bool selected) {
    _tapOnUrl = selected;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
