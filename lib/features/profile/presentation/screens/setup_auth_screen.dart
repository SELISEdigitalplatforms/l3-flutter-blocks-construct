import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/asset_helper.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pinput/pinput.dart';

import '../../../../theme/app_colors.dart';

class SetupAuthenticationScreen extends ConsumerStatefulWidget {
  const SetupAuthenticationScreen({super.key});

  @override
  ConsumerState<SetupAuthenticationScreen> createState() => _SetupAuthenticationState();
}

class _SetupAuthenticationState extends ConsumerState<SetupAuthenticationScreen> {
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
                  child: Text(localizationsContext.setUpAuthenticatorApp,
                      overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.titleLarge,),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSecondaryContainer),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(localizationsContext.followInstructionsBelow,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer)),
            SizedBox(height: 24),
            Text(
              localizationsContext.stepOne,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 16),
            Center(
              child: Image.asset(
                AssetHelper.qrCode,
                width: 160,
                height: 160,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                localizationsContext.stepOneOr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              localizationsContext.stepTwo,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 16),
            Align(
              alignment: FractionalOffset.center,
              child: Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 40,
                  height: 48,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.neutral90, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onCompleted: (value) {
                  //TODO : Add pin input function
                },
              ),
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
                        width: width * 0.5 - 32,
                        child: AppElevatedButton(
                          title: localizationsContext.cancel,
                          isUppercase: false,
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                          borderWidth: 1,
                          borderColor: AppColors.neutral90,
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ),
                      SizedBox(
                        width: width * 0.5 - 32,
                        child: AppElevatedButton(
                          title: localizationsContext.verify,
                          isUppercase: false,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          onPressed: () {
                            context.pushNamed(
                              AppRoutes.manageAuth.name,
                              queryParameters: {'previousRoute': AppRoutes.twoFactorAuth.path},
                            );
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
