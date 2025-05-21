import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/providers/change_password_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../routing/app_routes.dart';
import '../../../common/presentation/widgets/password_input_form_field_widget.dart';
import '../../../common/presentation/widgets/password_strength_indicator_widget.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  static const path = '/change-password';

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final form = FormGroup({
    'currentPassword': FormControl<String>(
      validators: [Validators.required],
    ),
    'newPassword': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8),
      ],
    ),
    'confirmPassword': FormControl<String>(
      validators: [Validators.required],
    ),
  }, validators: [
    Validators.mustMatch('newPassword', 'confirmPassword')
  ]);

  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final changePasswordState = ref.watch(changePasswordProvider);
    final changePasswordNotifier = ref.read(changePasswordProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 50,
        ),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localizationsContext.updatePassword, style: Theme.of(context).textTheme.titleLarge),
                        IconButton(
                          icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSecondaryContainer),
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(localizationsContext.updatePasswordDescription,
                        textAlign: TextAlign.left, style: Theme.of(context).textTheme.titleSmall!),
                    const SizedBox(height: 24.0),
                    PasswordInputFormFieldWidget(
                      formControlName: "currentPassword",
                      label: localizationsContext.currentPassword,
                    ),
                    const SizedBox(height: 16),
                    PasswordInputFormFieldWidget(
                      formControlName: "newPassword",
                      label: localizationsContext.newPassword,
                    ),
                    const SizedBox(height: 16),
                    PasswordInputFormFieldWidget(
                      formControlName: "confirmPassword",
                      label: localizationsContext.confirmNewPassword,
                    ),
                    const SizedBox(height: 16),
                    ReactiveValueListenableBuilder(
                      formControlName: 'newPassword',
                      builder: (context, control, child) {
                        return PasswordStrengthIndicatorWidget(password: control.value?.toString() ?? '');
                      },
                    ),
                    const SizedBox(height: 150), // space before buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 40,
                          width: width * 0.4,
                          child: AppElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            title: localizationsContext.cancel,
                            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                            foregroundColor: Theme.of(context).colorScheme.onSurface,
                            borderColor: AppColors.neutral90,
                            isUppercase: false,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: width * 0.4,
                          child: AppElevatedButton(
                            onPressed: () async {
                              bool success = await changePasswordNotifier.changePassword(
                                form.control('newPassword').value?.toString() ?? "",
                                form.control('currentPassword').value?.toString() ?? "",
                              );

                              if (success) {
                                context.pushNamed(
                                  AppRoutes.passwordUpdated.name,
                                  queryParameters: {'previousRoute': AppRoutes.profile.path},
                                );
                              } else {
                                // Show SnackBar if login fails
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(changePasswordState.message ?? "Login failed"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            title: localizationsContext.update,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            isUppercase: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
