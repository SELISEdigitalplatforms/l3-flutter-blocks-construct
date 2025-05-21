import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/language_provider.dart';

class LanguageDropdown extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return DropdownButton<Locale>(
      value: locale,
      underline: Container(),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          ref.read(localeProvider.notifier).changeLocale(newLocale);
        }
      },
      icon: Icon(Icons.keyboard_arrow_down_sharp),
      elevation: 0,
      items: const [
        DropdownMenuItem(
          value: Locale('en'),
          child: Text("EN"),
        ),
        DropdownMenuItem(
          value: Locale('de'),
          child: Text("DE"),
        ),
      ],
    );
  }
}
