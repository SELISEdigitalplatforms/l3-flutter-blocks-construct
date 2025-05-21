import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/asset_helper.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmailSentScreen extends ConsumerStatefulWidget {
  const EmailSentScreen({super.key});

  @override
  ConsumerState<EmailSentScreen> createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends ConsumerState<EmailSentScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final localizationsContext = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Blocks Logo
              Image(
                width: 115,
                height: 128,
                image: const AssetImage(AssetHelper.emailSent),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: width - 48,
                child: SizedBox(
                  child: Text(
                    localizationsContext.emailSent,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Text(
                localizationsContext.emailSentMessage,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 16),

              // change password
              SizedBox(
                width: width - 48,
                height: 40,
                child: AppElevatedButton(
                  title: localizationsContext.changePassword,
                  isUppercase: false,
                  onPressed: () {
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        AppRouter.instance.navigation.goNamed(AppRoutes.resetPassword.name);
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 24),

              // log in
              SizedBox(
                width: width - 48,
                height: 40,
                child: AppElevatedButton(
                  title: localizationsContext.login,
                  isUppercase: false,
                  onPressed: () {
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        AppRouter.instance.navigation.goNamed(AppRoutes.login.name);
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 24),

              // Change Email Address
              SizedBox(
                width: width - 48,
                height: 40,
                child: AppElevatedButton(
                  title: localizationsContext.changeEmailAddress,
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  borderColor: AppColors.neutral90,
                  isUppercase: false,
                  onPressed: () {
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        AppRouter.instance.navigation.goNamed(AppRoutes.forgotPass.name);
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
