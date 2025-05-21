import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/providers/login_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/form_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final localizationsContext = AppLocalizations.of(context)!;

    return SizedBox(
      height: 40,
      child: AppElevatedButton(
        isDisable: !ref.watch(formProvider).isValid ||
            ref.watch(loginProvider).isLoading ||
            ref.watch(formProvider).isSubmissionInProgress,
        isLoading: ref.watch(formProvider).isSubmissionInProgress,
        title: AppLocalizations.of(context)!.login,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        isUppercase: false,
        disabledBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
        disabledTextColor: Theme.of(context).colorScheme.onPrimaryContainer,
        onPressed: () async {
          final email = ref.watch(formProvider).formValues['emailController'];
          final password = ref.watch(formProvider).formValues['passwordController'];
          final result = await ref.read(formProvider.notifier).submitForm<bool>(() async {
            return ref.read(loginProvider.notifier).login(
                  email.toString().trim(),
                  password.toString().trim(),
                );
          });
          if (result) {
            // Navigate to Dashboard Screen on successful login
            AppRouter.instance.navigation.goNamed(AppRoutes.dashboard.name);
          } else {
            // Show SnackBar if login fails
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    ref.watch(loginProvider).message ?? localizationsContext.loginFailed,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
