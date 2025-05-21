import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/asset_helper.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/widgets/signup_button_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/constants/widget_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_custom_appbar.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/presentation/widgets/email_input_form_field_widget.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final signupForm = FormGroup({
    'emailController': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.pattern(WidgetConstants.emailValidationPattern)],
    ),
    'termsAndConditionsAgreed': FormControl<bool>(
      value: false,
      validators: [Validators.required],
    ),
  });

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ReactiveForm(
          formGroup: signupForm,
          child: SingleChildScrollView(
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
                      localizationsContext.signUpDescription,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      localizationsContext.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Future.delayed(const Duration(seconds: 2), () {
                          if (context.mounted) {
                            AppRouter.instance.navigation.goNamed(AppRoutes.login.name);
                          }
                        });
                      },
                      child: Text(
                        localizationsContext.login,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // email
                EmailInputFormFieldWidget(),
                SizedBox(height: 16),

                // terms and conditions
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: ReactiveCheckbox(
                        formControlName: 'termsAndConditionsAgreed',
                        activeColor: Color(0xFF01827F),
                      ),
                    ),
                    SizedBox(
                      width: width - 100,
                      child: Text.rich(
                        TextSpan(
                          text: localizationsContext.iAgreeThatThe + ' ',
                          style: Theme.of(context).textTheme.titleSmall,
                          children: <TextSpan>[
                            TextSpan(
                              text: localizationsContext.termsOfService,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: " ${localizationsContext.andAcknowledge} ",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            TextSpan(
                              text: localizationsContext.privacyPolicy,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: '.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // sign up button
                SignupButton(
                  email: signupForm.control('emailController').value ?? "",
                  isValid: signupForm.valid,
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
