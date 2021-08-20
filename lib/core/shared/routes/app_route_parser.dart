import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/app_link.dart';

class AppRouteParser extends RouteInformationParser<AppLink> {
  @override
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    final link = AppLink.fromLocation(routeInformation.location.toString());
    return link;
  }

  @override
  RouteInformation restoreRouteInformation(AppLink appLink) {
    final location = appLink.toLocation();
    return RouteInformation(location: location);
  }
}
