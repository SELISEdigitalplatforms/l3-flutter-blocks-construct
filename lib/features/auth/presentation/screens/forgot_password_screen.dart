import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/asset_helper.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/widgets/forget_password_button_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/constants/widget_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/form_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/presentation/widgets/email_input_form_field_widget.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final forgotPasswordForm = FormGroup({
    'emailController': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.pattern(WidgetConstants.emailValidationPattern)],
    ),
  });

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(formProvider.notifier).setFormGroup(forgotPasswordForm);
    });
  }

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
          child: ReactiveForm(
            formGroup: forgotPasswordForm,
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
                      localizationsContext.forgotYourPassword,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Text(
                  localizationsContext.forgotPasswordMessage,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 16),

                // email
                EmailInputFormFieldWidget(),
                SizedBox(height: 24),

                // send reset link
                SizedBox(
                  width: width - 48,
                  height: 40,
                  child: ForgetPasswordButton(
                    email: forgotPasswordForm.control('emailController').value,
                  ),
                ),
                SizedBox(height: 24),

                // go to login
                SizedBox(
                  width: width - 48,
                  height: 40,
                  child: AppElevatedButton(
                    title: localizationsContext.goToLogin,
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    borderColor: AppColors.neutral90,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
