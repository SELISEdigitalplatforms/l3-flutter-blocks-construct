import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupButton extends ConsumerWidget {
  final String email;
  final bool isValid;

  const SignupButton({
    super.key,
    required this.email,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final localizationsContext = AppLocalizations.of(context)!;

    return SizedBox(
      width: width - 48,
      height: 40,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          disabledBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          disabledForegroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        onPressed: !isValid
            ? null // Disable button while loading
            : () async {},
        child: Text(
          localizationsContext.signup,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }
}
