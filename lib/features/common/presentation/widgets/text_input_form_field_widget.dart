import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TextInputFormFieldWidget extends StatefulWidget {
  const TextInputFormFieldWidget({
    super.key,
    this.title,
    this.formControlName,
    this.emptyMessage,
  });

  final String? title;
  final String? formControlName;
  final String? emptyMessage;

  @override
  State<TextInputFormFieldWidget> createState() => _TextInputFormFieldWidgetState();
}

class _TextInputFormFieldWidgetState extends State<TextInputFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;

    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizationsContext.fullName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        ReactiveTextField(
          formControlName: widget.formControlName ?? 'textController',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: localizationsContext.fullNameHint,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.neutral90),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.neutral90),
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
            helperMaxLines: 2,
            errorMaxLines: 2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validationMessages: {
            ValidationMessage.required: (_) =>
                widget.emptyMessage ?? localizationsContext.textInputFormFieldEmptyMessage,
          },
        ),
      ],
    );
  }
}
