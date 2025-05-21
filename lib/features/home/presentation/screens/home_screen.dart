import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_custom_appbar.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_custom_bottom_nav.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: _scaffoldKey,
      appBar: AppCustomAppBar(
        showLanguageSwitch: true,
        showProfileButton: true,
        scaffoldKey: _scaffoldKey,
      ),
      endDrawer: Drawer(
        child: AppDrawer(
          _scaffoldKey,
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: widget.navigationShell.currentIndex,
        onItemSelected: _switchBranch,
      ),
      body: widget.navigationShell,
    );
  }

  void _switchBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
