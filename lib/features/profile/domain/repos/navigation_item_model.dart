import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';

class NavigationItemModel {
  final String title;
  final String? icon;
  final AppRoutes? path;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final Widget? leading;
  final Widget? trailing;
  final NavigationItemType type;
  final String? url;
  final bool launchExternally;
  final bool hasDivider;

  NavigationItemModel({
    required this.title,
    this.icon,
    this.path,
    this.trailingIcon,
    this.leadingIcon,
    this.leading,
    this.trailing,
    this.type = NavigationItemType.normal,
    this.url,
    this.launchExternally = false,
    this.hasDivider = false,
  });
}

enum NavigationItemType {
  logout,
  normal,
  route,
  theme,
}
