import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/password_strength_condition_widget.dart';

import '../../../../theme/app_colors.dart';

class PasswordStrengthIndicatorWidget extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicatorWidget({
    super.key,
    required this.password,
  });

  bool get hasMinLength => password.length >= 8;

  bool get hasUppercase => RegExp(r'(?=.*[A-Z])').hasMatch(password);

  bool get hasLowercase => RegExp(r'(?=.*[a-z])').hasMatch(password);

  bool get hasDigit => RegExp(r'(?=.*\d)').hasMatch(password);

  bool get hasSpecialChar => RegExp(r'(?=.*[@\$#!%*?&])').hasMatch(password);

  int get strengthVal =>
      (hasMinLength ? 1 : 0) +
      (hasUppercase ? 1 : 0) +
      (hasLowercase ? 1 : 0) +
      (hasDigit ? 1 : 0) +
      (hasSpecialChar ? 1 : 0);

  @override
  Widget build(BuildContext context) {
    int s = strengthVal;
    final localizationsContext = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(border: Border.all(color: AppColors.neutral90), borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizationsContext.passwordStrength,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: s / 5,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: 8),
          Text(localizationsContext.checkPasswordStrength, style: Theme.of(context).textTheme.titleSmall!),
          SizedBox(height: 8),
          Text(localizationsContext.passwordMustContain, style: Theme.of(context).textTheme.titleSmall!),
          SizedBox(height: 8),
          PasswordStrengthConditionWidget(isMatched: hasMinLength, conditionText: localizationsContext.passwordReq1),
          SizedBox(height: 8),
          PasswordStrengthConditionWidget(isMatched: hasLowercase && hasUppercase, conditionText: localizationsContext.passwordReq2),
          SizedBox(height: 8),
          PasswordStrengthConditionWidget(isMatched: hasDigit, conditionText: localizationsContext.passwordReq3),
          SizedBox(height: 8),
          PasswordStrengthConditionWidget(isMatched: hasSpecialChar, conditionText: localizationsContext.passwordReq4),
        ],
      ),
    );
  }
}

