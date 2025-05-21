import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/repos/two_factor_navigation_item_model%20copy.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../theme/app_colors.dart';

class TwoFactorAuthenticationScreen extends ConsumerStatefulWidget {
  const TwoFactorAuthenticationScreen({super.key});

  @override
  ConsumerState<TwoFactorAuthenticationScreen> createState() => _TwoFactorAuthenticationState();
}

class _TwoFactorAuthenticationState extends ConsumerState<TwoFactorAuthenticationScreen> {
  List<TwoFactorNavigationItemModel> getTwoFactorNavigationItems(BuildContext context) {
    final navigationItems = [
      TwoFactorNavigationItemModel(
        title: "Authentication App",
        leadingIcon: Icons.phone_android_outlined,
        trailingIcon: Icons.arrow_forward_ios_sharp,
        type: TwoFactorNavigationItemType.authenticationApp,
      ),
      TwoFactorNavigationItemModel(
        title: "Email Verification",
        leadingIcon: Icons.mail_outline,
        trailingIcon: Icons.arrow_forward_ios_sharp,
        type: TwoFactorNavigationItemType.emailVerification,
      ),
    ];
    return navigationItems;
  }

  @override
  Widget build(BuildContext context) {
    List<TwoFactorNavigationItemModel> navigationItems = getTwoFactorNavigationItems(context);
    final localizationsContext = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 2,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: AppColors.neutral90,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    localizationsContext.twoFATitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              localizationsContext.twoFADescription,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: navigationItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      navigationItems[index].title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Icon(
                        navigationItems[index].leadingIcon,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    horizontalTitleGap: 8,
                    onTap: () {
                      switch (navigationItems[index].type) {
                        case TwoFactorNavigationItemType.authenticationApp:
                          context.pushNamed(
                            AppRoutes.setupAuth.name,
                            queryParameters: {'previousRoute': AppRoutes.twoFactorAuth.path},
                          );
                          break;
                        case TwoFactorNavigationItemType.emailVerification:
                          // AppRouter.instance.navigation.goNamed(AppRoutes.login.name);
                          break;
                        default:
                      }
                    },
                    trailing: Icon(
                      navigationItems[index].trailingIcon,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    shape: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1,
                      ),
                      bottom: index == navigationItems.length - 1
                          ? BorderSide(
                              color: Theme.of(context).colorScheme.outlineVariant,
                              width: 1,
                            )
                          : BorderSide.none,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
