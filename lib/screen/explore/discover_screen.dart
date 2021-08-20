import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/data_model/models.dart';
import 'package:flutter_recipe_proto_app/infrastructure/api/mock_food_api_service.dart';
import 'package:flutter_recipe_proto_app/screen/explore/widget/friend_post_list_view.dart';
import 'package:flutter_recipe_proto_app/screen/explore/widget/today_recipe_list_view.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final mockService = MockFoodApiService();

  late ScrollController _controller;

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('I am at the bottom');
    } else if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('I am at the top');
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color appColor = const Color.fromRGBO(255, 196, 1, 1);
    return FutureBuilder<ExploreData?>(
      future: mockService.getExploreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data;
          return ListView(
            controller: _controller,
            scrollDirection: Axis.vertical,
            children: [
              TodayRecipeListView(
                recipes: recipes?.todayRecipes,
              ),
              const SizedBox(height: 16),
              FriendPostListView(friendPosts: recipes?.friendPosts),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: appColor,
            ),
          );
        }
      },
    );
  }
}
