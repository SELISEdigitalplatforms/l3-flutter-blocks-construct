import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound(
      {super.key,
      this.title,
      this.subtitle,
      this.onPressed,
      this.buttonTextMessage,
      this.iconSize});

  final Widget? title;
  final Widget? subtitle;
  final void Function()? onPressed;
  final String? buttonTextMessage;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final localizationContext = AppLocalizations.of(context)!;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: iconSize ?? 56,
            color: const Color.fromRGBO(101, 192, 209, 1),
          ),
          const SizedBox(height: 20),
          title ??
              Text(
                localizationContext.noDataFound,
                style: Theme.of(context).textTheme.titleMedium,
              ),
          if (subtitle != null) const SizedBox(height: 8),
          if (subtitle != null) subtitle!,
          if (onPressed != null) const SizedBox(height: 32),
          if (onPressed != null)
            AppElevatedButton(
              onPressed: onPressed ??
                  () {
                    context.pop();
                  },
              title: buttonTextMessage ?? localizationContext.back,
            )
        ],
      ),
    );
  }
}
