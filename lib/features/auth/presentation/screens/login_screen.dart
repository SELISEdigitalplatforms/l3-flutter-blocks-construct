import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/asset_helper.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/widgets/login_button_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/constants/widget_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/form_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_custom_appbar.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/password_input_form_field_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/presentation/widgets/app_elevated_button.dart';
import '../../../common/presentation/widgets/email_input_form_field_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/providers/login_provider.dart';

import '../../../profile/presentation/providers/biometric_auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final loginForm = FormGroup({
    'emailController': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.pattern(WidgetConstants.emailValidationPattern)],
    ),
    'passwordController': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
  });

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(formProvider.notifier).setFormGroup(loginForm);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final localizationsContext = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppCustomAppBar(
        showThemeSwitchButton: true,
        showLanguageSwitch: true,
        showLogo: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: ReactiveForm(
            formGroup: loginForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blocks Logo
                Image(
                  width: 132,
                  height: 56,
                  image: const AssetImage(AssetHelper.logo),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: width - 48,
                  child: SizedBox(
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     Text(
                //       AppLocalizations.of(context)!.noAccount,
                //       style: Theme.of(context).textTheme.titleSmall,
                //     ),
                //     TextButton(
                //       style: TextButton.styleFrom(
                //         padding: EdgeInsets.zero,
                //       ),
                //       onPressed: () {
                //         Future.delayed(const Duration(seconds: 2), () {
                //           if (context.mounted) {
                //             AppRouter.instance.navigation.goNamed(AppRoutes.signUp.name);
                //           }
                //         });
                //       },
                //       child: Text(
                //         AppLocalizations.of(context)!.signup,
                //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //               color: Theme.of(context).colorScheme.primary,
                //             ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 16),

                // email
                EmailInputFormFieldWidget(),
                SizedBox(height: 16),

                PasswordInputFormFieldWidget(
                  label: localizationsContext.password,
                  formControlName: 'passwordController',
                ),
                SizedBox(height: 4),

                // forgot password
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        AppRouter.instance.navigation.goNamed(AppRoutes.forgotPass.name);
                      }
                    });
                  },
                  child: Text(
                    localizationsContext.forgotPassword,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                SizedBox(height: 24),

                // login button
                SizedBox(
                  width: width - 48,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: LoginButton(),
                      ),
                      SizedBox(width: 10),
                      AppElevatedButton(
                        onPressed: () async {
                          final loginNotifier = ref.read(loginProvider.notifier);
                          final success = await loginNotifier.loginWithBiometrics();

                          if (!success) {
                            final errorMessage =
                                ref.read(loginProvider).message ?? localizationsContext.biometricNotEnabledMessage;

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  localizationsContext.biometricNotEnabledTitle,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                content: Text(
                                  errorMessage,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text(
                                      localizationsContext.ok,
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            ref.read(biometricAuthProvider.notifier).setBiometricEnabled(true);
                            AppRouter.instance.navigation.goNamed(AppRoutes.dashboard.name);
                          }
                        },
                        title: "",
                        foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        borderColor: AppColors.neutral90,
                        borderRadius: 6,
                        isUppercase: false,
                        leadingIcon: Icon(
                          size: 20,
                          Icons.fingerprint,
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // SSO
                SizedBox(
                  width: width - 48,
                  height: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: AppColors.neutral80,
                        height: 1,
                        width: 80,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          localizationsContext.orContinueWith,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.neutral80),
                        ),
                      ),
                      Container(
                        color: AppColors.neutral80,
                        height: 1,
                        width: 80,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: width - 48,
                  height: 48,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: AppColors.neutral80),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AssetHelper.googleLogo),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: AppColors.neutral80),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AssetHelper.microsoftLogo),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: AppColors.neutral80),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AssetHelper.linkedinLogo),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: AppColors.neutral80),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AssetHelper.githubLogo),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
