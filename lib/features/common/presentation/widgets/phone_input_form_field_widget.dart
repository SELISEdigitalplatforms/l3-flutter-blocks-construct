import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/localization/language_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/constants/widget_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PhoneInputFormFieldWidget extends ConsumerStatefulWidget {
  const PhoneInputFormFieldWidget({
    super.key,
    this.title,
  });

  final String? title;

  @override
  ConsumerState<PhoneInputFormFieldWidget> createState() => _PhoneInputFormFieldState();
}

class _PhoneInputFormFieldState extends ConsumerState<PhoneInputFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    final languageCode = ref.watch(localeProvider).languageCode;

    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? localizationsContext.mobileNo,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        ReactiveFormField<String, String>(
            formControlName: 'phoneController',
            validationMessages: {
              ValidationMessage.required: (_) => localizationsContext.phoneInputFormFieldEmptyMessage,
            },
            builder: (field) {
              return IntlPhoneField(
                dropdownIconPosition: IconPosition.trailing,
                dropdownIcon: const Icon(Icons.keyboard_arrow_down),
                flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12),
                languageCode: languageCode,
                initialValue: field.value,
                onChanged: (phone) {
                  field.didChange(phone.completeNumber);
                },
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: WidgetConstants.phoneInputFormFieldHint,
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
                  helperMaxLines: 2,
                  errorMaxLines: 2,
                  errorText: field.errorText,
                  counterText: '',
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
              );
            })
      ],
    );
  }
}
