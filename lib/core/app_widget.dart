import 'package:flutter/material.dart';

import 'package:flutter_recipe_proto_app/logic/app_state_manager.dart';
import 'package:flutter_recipe_proto_app/logic/grocery_manager.dart';
import 'package:flutter_recipe_proto_app/logic/profile_manager.dart';

import 'package:provider/provider.dart';

import 'shared/routes/app_route_parser.dart';
import 'shared/theme/app_theme.dart';
import 'shared/routes/app_router.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();

  late AppRouter _appRouter;
  final routeParser = AppRouteParser();

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GroceryManager>(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider<ProfileManager>(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider<AppStateManager>(
          create: (context) => _appStateManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = RecipeAppTheme.dark();
          } else {
            theme = RecipeAppTheme.light();
          }

          return MaterialApp.router(
            title: 'App Recipe',
            debugShowCheckedModeBanner: false,
            theme: theme,
            backButtonDispatcher: RootBackButtonDispatcher(),
            routeInformationParser: routeParser,
            routerDelegate: _appRouter,
          );
        },
      ),
    );
  }
}
