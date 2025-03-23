import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final bool showBottomNavItemUnselected;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    this.showBottomNavItemUnselected = false,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  bool hideBannerAfterBannerEndTime = false;
  String? environment;

  @override
  void initState() {
    environment = const String.fromEnvironment('ENV', defaultValue: 'dev');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizationContext = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final totalBottomNavHeight =
        kBottomNavigationBarHeight + bottomPadding + 14;
    return Container(
      alignment: Alignment.bottomCenter,
      height: totalBottomNavHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(75),
            blurRadius: 14,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          BottomNavigationBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            items: <BottomNavigationBarItem>[
              _buildNavigationItem(
                Icons.dashboard,
                localizationContext.dashboard,
              ),
              _buildNavigationItem(
                Icons.security,
                localizationContext.iam,
              ),
              _buildNavigationItem(
                Icons.inventory,
                localizationContext.inventory,
              ),
              _buildNavigationItem(
                Icons.menu,
                localizationContext.more,
              ),
            ],
            currentIndex: widget.selectedIndex,
            selectedItemColor: widget.showBottomNavItemUnselected
                ? Theme.of(context).colorScheme.onSecondaryContainer
                : Theme.of(context).colorScheme.primary,
            unselectedItemColor:
                Theme.of(context).colorScheme.onSecondaryContainer,
            onTap: widget.onItemSelected,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 24,
        ),
      ),
      label: label,
    );
  }
}
