import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../theme/app_colors.dart';

class ManageAuthenticationScreen extends ConsumerStatefulWidget {
  const ManageAuthenticationScreen({super.key});

  @override
  ConsumerState<ManageAuthenticationScreen> createState() => _ManageAuthenticationState();
}

class _ManageAuthenticationState extends ConsumerState<ManageAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                    localizationsContext.manageTwoFA,
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
              localizationsContext.manageTwoFADescription,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
            ),
            SizedBox(height: 24),
            Container(
              width: width - 32,
              height: 80,
              padding: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(localizationsContext.authAppSetUpSuccessful,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Theme.of(context).colorScheme.onTertiary)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Icon(
                          Icons.phone_android_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(localizationsContext.authenticationApp, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  Text(localizationsContext.disable,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(context).colorScheme.onError))
                ],
              ),
            ),
            AppElevatedButton(
              title: localizationsContext.downloadRecoveryCodes,
              foregroundColor: Theme.of(context).colorScheme.primary,
              isUppercase: false,
              buttonTextSize: 16,
              leadingIcon: Container(
                padding: EdgeInsets.only(right: 4),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Icon(
                  Icons.file_download_outlined,
                  size: 24,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  // width: width,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.6 - 32,
                        child: AppElevatedButton(
                          title: localizationsContext.switchAuthenticator,
                          isUppercase: false,
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          leadingIcon: Container(
                            padding: EdgeInsets.only(right: 4),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Icon(
                              Icons.sync,
                              size: 24,
                            ),
                          ),
                          onPressed: () {
                            if (context.mounted) {
                              // Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: width * 0.4 - 32,
                        child: AppElevatedButton(
                          title: localizationsContext.logout,
                          isUppercase: false,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          onPressed: () {
                            if (context.mounted) {
                              // AppRouter.instance.navigation.goNamed(AppRoutes.profile.name);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
