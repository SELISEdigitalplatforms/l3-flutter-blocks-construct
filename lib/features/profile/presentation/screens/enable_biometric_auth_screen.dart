import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/presentation/providers/profile_provider.dart';
import '../../../common/presentation/widgets/password_input_form_field_widget.dart';
import '../providers/biometric_auth_provider.dart';

class BiometricAuthScreen extends ConsumerWidget {
  const BiometricAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationsContext = AppLocalizations.of(context)!;
    final biometricController = ref.watch(biometricAuthProvider);
    final controller = ref.read(biometricAuthProvider.notifier);
    final profileState = ref.watch(profileProvider);
    final email = profileState.profileData?.data?.email ?? '';

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
        child: ReactiveForm(
          formGroup: controller.passwordForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 2,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
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
                  Text(
                    localizationsContext.setUpAuthenticatorApp,
                    style: Theme.of(context).textTheme.titleLarge,
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
              const SizedBox(height: 8),
              Text(
                localizationsContext.biometricAuthDescription,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 24),
              if (!biometricController)
                PasswordInputFormFieldWidget(
                  label: localizationsContext.password,
                  formControlName: 'password',
                ),
              const SizedBox(height: 24),
              AppElevatedButton(
                onPressed: () async {
                  if (biometricController) {
                    await controller.disableBiometricAuth();
                  } else {
                    final passwordControl = controller.passwordForm.control('password');

                    if (passwordControl.valid) {
                      await controller.enableBiometricAuth(email: email);
                    } else {
                      passwordControl.markAsTouched();
                    }
                  }
                },
                title: biometricController
                    ? localizationsContext.disableBiometricAuth
                    : localizationsContext.enableBiometricAuth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
