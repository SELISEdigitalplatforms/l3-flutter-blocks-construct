import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/providers/logout_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/profile_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/horizontal_line_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/profile_image_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/repos/navigation_item_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/theme_provider.dart';

class AppDrawer extends ConsumerWidget {
  final GlobalKey<ScaffoldState>? _scaffoldKey;
  static const double _minTileHeight = 54;
  static const double _gap = 24;

  const AppDrawer(this._scaffoldKey, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeProvider.notifier);
    final themeMode = ref.watch(themeProvider);
    final profileDetails = ref.watch(profileProvider).profileData?.data;
    final logoutState = ref.watch(logoutProvider);
    final logoutNotifier = ref.read(logoutProvider.notifier);

    List<NavigationItemModel> navigationItems = _getProfileNavigationItems(context, themeMode);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 46, horizontal: 16),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  _scaffoldKey?.currentState?.closeEndDrawer();
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  size: 24,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: _gap),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                ProfileImageWidget(
                  width: 48,
                  height: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${profileDetails?.firstName ?? ''} ${profileDetails?.lastName ?? ''}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (profileDetails?.userName?.split('@').first ?? '').toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          HorizontalLineWidget(
            margin: const EdgeInsets.only(bottom: (_minTileHeight / 2 + 1) - _gap),
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: navigationItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  minTileHeight: _minTileHeight,
                  title: Text(
                    navigationItems[index].title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  onTap: _getOnTap(context, index, logoutNotifier, logoutState, themeNotifier, themeMode),
                  trailing: Icon(
                    navigationItems[index].trailingIcon,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    size: 16,
                  ),
                  shape: navigationItems[index].hasDivider
                      ? Border(
                          top: BorderSide(
                            color: AppColors.neutral90,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: AppColors.neutral90,
                            width: 1,
                          ))
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<NavigationItemModel> _getProfileNavigationItems(
    BuildContext context,
    ThemeMode themeMode,
  ) {
    final localizationsContext = AppLocalizations.of(context)!;
    final navigationItems = [
      NavigationItemModel(
        title: localizationsContext.myProfile,
        trailingIcon: Icons.keyboard_arrow_right,
        type: NavigationItemType.route,
        path: AppRoutes.profile,
      ),
      NavigationItemModel(
        title: localizationsContext.about,
        trailingIcon: Icons.keyboard_arrow_right,
        hasDivider: true,
      ),
      NavigationItemModel(
        title: localizationsContext.privacyPolicy,
        trailingIcon: Icons.keyboard_arrow_right,
      ),
      NavigationItemModel(
        title: localizationsContext.theme,
        trailingIcon: themeMode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        hasDivider: true,
        type: NavigationItemType.theme,
      ),
      NavigationItemModel(
        title: localizationsContext.logout,
        trailingIcon: Icons.logout,
        type: NavigationItemType.logout,
      ),
    ];
    return navigationItems;
  }

  GestureTapCallback? _getOnTap(BuildContext context, int index, LogoutNotifier logoutNotifier, LogoutState logoutState,
      ThemeNotifier themeNotifier, ThemeMode themeMode) {
    final localizationsContext = AppLocalizations.of(context)!;
    final navigationItems = _getProfileNavigationItems(context, themeMode);
    switch (navigationItems[index].type) {
      case NavigationItemType.theme:
        return () {
          themeNotifier.toggleTheme();
        };
      case NavigationItemType.route:
        return () {
          _scaffoldKey?.currentState?.closeEndDrawer();
          context.replaceNamed(
            navigationItems[index].path!.name,
            queryParameters: {'previousRoute': AppRouter.instance.navigation.currentPath.path},
          );
        };
      case NavigationItemType.logout:
        return () async {
          _scaffoldKey?.currentState?.closeEndDrawer();
          await logoutNotifier.logout();
          AppRouter.instance.navigation.goNamed(AppRoutes.login.name);
        };
      default:
        return null;
    }
  }
}
