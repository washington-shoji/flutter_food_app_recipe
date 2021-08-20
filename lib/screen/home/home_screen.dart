import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/screen_route.dart';
import 'package:flutter_recipe_proto_app/logic/app_state_manager.dart';
import 'package:flutter_recipe_proto_app/logic/profile_manager.dart';
import 'package:flutter_recipe_proto_app/screen/explore/discover_screen.dart';
import 'package:flutter_recipe_proto_app/screen/grocery/grocery_screen.dart';
import 'package:flutter_recipe_proto_app/screen/recipe/recipe_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: FoodRecipeAppPages.home,
      key: ValueKey(FoodRecipeAppPages.home),
      child: HomeScreen(
        currentTab: currentTab,
      ),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Widget> pages = [
    const DiscoverScreen(),
    RecipeScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Yummex Recipe App',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              profileButton(),
            ],
          ),
          /*
        Want your users to easily switch between widgets in your app? 
        IndexedStack has you covered! Swap between widgets, without animation, 
        and the state of the widgets is preserved.
        https://www.youtube.com/watch?v=_O0PPD1Xfbk 
         */
          body: IndexedStack(
            index: widget.currentTab,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: widget.currentTab,
            onTap: (index) {
              Provider.of<AppStateManager>(context, listen: false)
                  .goToTab(index);
            },
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: 'Discover'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.book), label: 'Recipes'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Shopping List'),
            ],
          ),
        );
      },
    );
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            // When emplementing cloud auth
            // User image will be fetched from cloud service
            'assets/profile_pics/person_male_avatar.png',
          ),
        ),
        onTap: () {
          Provider.of<ProfileManager>(context, listen: false)
              .tapOnProfile(true);
        },
      ),
    );
  }
}
