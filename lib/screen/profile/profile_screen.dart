import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/screen_route.dart';
import 'package:flutter_recipe_proto_app/core/shared/widget/circle_image.dart';
import 'package:flutter_recipe_proto_app/data_model/user.dart';
import 'package:flutter_recipe_proto_app/logic/app_state_manager.dart';
import 'package:flutter_recipe_proto_app/logic/profile_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    this.user,
  }) : super(key: key);
  final AppUser? user;

  static MaterialPage page(AppUser user) {
    return MaterialPage(
        name: FoodRecipeAppPages.profilePath,
        key: ValueKey(FoodRecipeAppPages.profilePath),
        child: ProfileScreen(
          user: user,
        ));
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        buildDarkModeRow(),
        ListTile(
          title: const Text('View some food recipe inspiration'),
          onTap: () async {
            if (kIsWeb) {
              await launch(
                  'https://www.epicurious.com/recipes-menus/easy-dinner-recipes-gallery');
            } else {
              Provider.of<ProfileManager>(context, listen: false)
                  .tapOnUrl(true);
            }
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
            Provider.of<AppStateManager>(context, listen: false).logout();
          },
        )
      ],
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Switch(
            value: widget.user?.darkMode ?? false,
            onChanged: (value) {
              Provider.of<ProfileManager>(context, listen: false).darkMode =
                  value;
            },
          )
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user?.profileImageUrl ?? ''),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.user?.firstName ?? '',
          style: const TextStyle(
            fontSize: 21,
          ),
        ),
        Text(widget.user?.role ?? ''),
        Text(
          '${widget.user?.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
