import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmailInputFormFieldWidget extends StatefulWidget {
  final String? title;
  final bool isReadOnly;

  const EmailInputFormFieldWidget({
    super.key,
    this.title,
    this.isReadOnly = false,
  });

  @override
  State<EmailInputFormFieldWidget> createState() => _EmailInputFormFieldWidgetState();
}

class _EmailInputFormFieldWidgetState extends State<EmailInputFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizationsContext.email, style: Theme.of(context).textTheme.titleSmall),
        ReactiveTextField(
          formControlName: 'emailController',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          readOnly: widget.isReadOnly,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: widget.isReadOnly
                    ? Theme.of(context).colorScheme.onSurfaceVariant
                    : Theme.of(context).colorScheme.onSurface,
              ),
          decoration: InputDecoration(
            hintText: localizationsContext.emailInputFormFieldHint,
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            enabledBorder: widget.isReadOnly
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.neutral90),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.neutral90),
                  ),
            focusedBorder: widget.isReadOnly
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.neutral90),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.neutral90),
                  ),
            helperMaxLines: 2,
            errorMaxLines: 2,
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validationMessages: {
            ValidationMessage.required: (error) => localizationsContext.emailInputFormFieldEmptyMessage,
            ValidationMessage.pattern: (error) => localizationsContext.emailInputFormFieldInvalidMessage,
            ValidationMessage.email: (error) => localizationsContext.emailInputFormFieldInvalidMessage,
          },
        ),
      ],
    );
  }
}
