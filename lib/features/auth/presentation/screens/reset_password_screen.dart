import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/providers/reset_password_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/form_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/password_strength_indicator_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/presentation/widgets/password_input_form_field_widget.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  // final String resetCode;

  const ResetPasswordScreen({super.key});

  // const ResetPasswordScreen({super.key, required this.resetCode});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final form = FormGroup({
    'newPassword': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(8),
    ]),
    'confirmPassword': FormControl<String>(validators: [Validators.required]),
    'code': FormControl<String>(validators: [Validators.required]),
  }, validators: [
    Validators.mustMatch('newPassword', 'confirmPassword')
  ]);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(formProvider.notifier).setFormGroup(form);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    // final code = widget.resetCode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 50,
          ),
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localizationsContext.resetPassword,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSecondaryContainer),
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  localizationsContext.resetPasswordDescription,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 24.0),
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
                const SizedBox(height: 16),
                ReactiveTextField(
                  decoration: InputDecoration(
                    hintText: localizationsContext.enterResetCode,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondaryContainer,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE2E2E2)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(),
                  ),
                  formControlName: 'code',
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
                          bool success = await ref.read(resetPasswordProvider.notifier).resetPassword(
                                form.control('newPassword').value?.toString() ?? "",
                                form.control('code').value?.toString() ?? "",
                              );

                          if (success) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(ref.watch(resetPasswordProvider).message ??
                                      localizationsContext.passwordResetSuccessfullyMessage),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Future.delayed(const Duration(seconds: 2), () {
                                if (context.mounted) {
                                  context.pushNamed(
                                    AppRoutes.passwordUpdated.name,
                                    queryParameters: {'previousRoute': AppRoutes.login.path},
                                  );
                                }
                              });
                            }
                          } else {
                            // Show SnackBar if reset password fails
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(ref.watch(resetPasswordProvider).message ??
                                      localizationsContext.passwordResetFailedMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
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
          ),
        ),
      ),
    );
  }
}
