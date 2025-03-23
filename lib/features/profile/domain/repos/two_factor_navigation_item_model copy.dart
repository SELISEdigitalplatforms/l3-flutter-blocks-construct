import 'package:flutter/material.dart';

class TwoFactorNavigationItemModel {
  final String title;
  final String? icon;
  // final PageRouteInfo? route;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final Widget? leading;
  final Widget? trailing;
  final TwoFactorNavigationItemType type;
  final String? url;
  final bool launchExternally;

  TwoFactorNavigationItemModel({
    required this.title,
    this.icon,
    // this.route,
    this.trailingIcon,
    this.leadingIcon,
    this.leading,
    this.trailing,
    this.type = TwoFactorNavigationItemType.none,
    this.url,
    this.launchExternally = false,
  });
}

enum TwoFactorNavigationItemType {
  authenticationApp,
  emailVerification,
  none,
}
