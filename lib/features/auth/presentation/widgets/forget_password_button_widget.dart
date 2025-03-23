import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/form_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordButton extends ConsumerWidget {
  final String email;

  const ForgetPasswordButton({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final localizationsContext = AppLocalizations.of(context)!;

    return SizedBox(
      width: width - 48,
      height: 40,
      child: AppElevatedButton(
        isDisable: !ref.watch(formProvider).isValid ||
            ref.watch(forgotPasswordProvider).isLoading ||
            ref.watch(formProvider).isSubmissionInProgress,
        isLoading: ref.watch(formProvider).isSubmissionInProgress,
        title: AppLocalizations.of(context)!.sendResetLink,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        isUppercase: false,
        disabledBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
        disabledTextColor: Theme.of(context).colorScheme.onPrimaryContainer,
        onPressed: () async {
          final result = await ref.read(formProvider.notifier).submitForm<bool>(() async {
            return ref.read(forgotPasswordProvider.notifier).forgotPassword(
                  email.toString().trim(),
                );
          });

          if (result) {
            AppRouter.instance.navigation.goNamed(AppRoutes.emailSent.name);
          } else {
            // Show SnackBar if forgetPassword fails
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    ref.watch(forgotPasswordProvider).message ?? localizationsContext.sentEmailFailed,
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
