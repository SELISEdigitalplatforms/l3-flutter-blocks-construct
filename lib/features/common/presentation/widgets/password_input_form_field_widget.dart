import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordInputFormFieldWidget extends StatefulWidget {
  final String formControlName;
  final String label;

  const PasswordInputFormFieldWidget({
    super.key,
    required this.formControlName,
    required this.label,
  });

  @override
  State<PasswordInputFormFieldWidget> createState() => _PasswordInputFormFieldState();
}

class _PasswordInputFormFieldState extends State<PasswordInputFormFieldWidget> {
  bool secureText = true;

  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: widget.label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              TextSpan(
                text: '*',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        ReactiveTextField(
          formControlName: widget.formControlName,
          obscureText: secureText,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            hintText: localizationsContext.enterYourPassword,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: AppColors.neutral90,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: AppColors.neutral90,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onError),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onError),
              borderRadius: BorderRadius.circular(6),
            ),
            errorStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  secureText = !secureText;
                });
              },
              child: (secureText)
                  ? Icon(
                      Icons.visibility_off_outlined,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      size: 16,
                    )
                  : Icon(
                      Icons.visibility_outlined,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      size: 16,
                    ),
            ),
            helperMaxLines: 2,
            errorMaxLines: 2,
          ),
          validationMessages: {
            ValidationMessage.required: (error) => localizationsContext.passwordNotEmptyMessage,
            ValidationMessage.mustMatch: (error) => localizationsContext.passwordMatchMessage,
            ValidationMessage.minLength: (error) => localizationsContext.passwordMinLengthMessage,
            'invalidCredentials': (error) => error.toString(),
          },
        ),
      ],
    );
  }
}
