import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/app_link.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/screen_route.dart';
import 'package:flutter_recipe_proto_app/logic/app_state_manager.dart';
import 'package:flutter_recipe_proto_app/logic/grocery_manager.dart';
import 'package:flutter_recipe_proto_app/logic/profile_manager.dart';
import 'package:flutter_recipe_proto_app/screen/grocery/widget/grocery_item_screen.dart';
import 'package:flutter_recipe_proto_app/screen/home/home_screen.dart';
import 'package:flutter_recipe_proto_app/screen/login/login_screen.dart';
import 'package:flutter_recipe_proto_app/screen/onboard/onboard_screen.dart';
import 'package:flutter_recipe_proto_app/screen/profile/profile_screen.dart';
import 'package:flutter_recipe_proto_app/screen/splash/splash_screen.dart';
import 'package:flutter_recipe_proto_app/screen/webview/webview_screen.dart';

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else if (!appStateManager.isLoggedIn) ...[
          LoginScreen.page(),
        ] else if (!appStateManager.isOnboardingComplete) ...[
          OnboardingScreen.page(),
        ] else ...[
          HomeScreen.page(appStateManager.getSelectedTab),
          if (groceryManager.isCreatingNewItem)
            GroceryItemScreen.page(onCreate: (item) {
              groceryManager.addItem(item);
            }),
          if (groceryManager.selectedIndex != null)
            GroceryItemScreen.page(
                item: groceryManager.selectedGroceryItem,
                index: groceryManager.selectedIndex,
                onUpdate: (item, index) {
                  groceryManager.updateItem(item, index);
                }),
          if (profileManager.didSelectUser)
            ProfileScreen.page(profileManager.getUser),
          if (profileManager.didTapOnRaywenderlich) WebViewScreen.page(),
        ]
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    if (route.settings.name == FoodRecipeAppPages.onboardingPath) {
      appStateManager.logout();
    }
    // Handle state when user closes grocery item screen
    if (route.settings.name == FoodRecipeAppPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(null);
    }
    // Handle state when user closes profile screen
    if (route.settings.name == FoodRecipeAppPages.profilePath) {
      profileManager.tapOnProfile(false);
    }
    // Handle state when user closes WebView screen
    if (route.settings.name == FoodRecipeAppPages.raywenderlich) {
      profileManager.tapOnUrl(false);
    }
    return true;
  }

  // Convert app state to applink
  AppLink getCurrentPath() {
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.kLoginPath);
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.kOnboardingPath);
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.kProfilePath);
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.kItemPath);
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem?.id;
      return AppLink(location: AppLink.kItemPath, itemId: id);
    } else {
      return AppLink(
          location: AppLink.kHomePath,
          currentTab: appStateManager.getSelectedTab);
    }
  }

  // Apply configuration helper
  @override
  AppLink get currentConfiguration => getCurrentPath();

  // Replace setNewRoutePath
  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    switch (newLink.location) {
      case AppLink.kProfilePath:
        profileManager.tapOnProfile(true);
        break;

      case AppLink.kItemPath:
        if (newLink.itemId != null) {
          groceryManager.setSelectedGroceryItem(newLink.itemId);
        } else {
          groceryManager.createNewItem();
        }

        profileManager.tapOnProfile(false);
        break;

      case AppLink.kHomePath:
        appStateManager.goToTab(newLink.currentTab ?? 0);
        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(null);
        break;

      default:
        break;
    }
  }
}
