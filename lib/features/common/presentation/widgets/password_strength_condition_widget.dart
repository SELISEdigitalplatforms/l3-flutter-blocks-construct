import 'package:flutter/material.dart';

class PasswordStrengthConditionWidget extends StatelessWidget {
  const PasswordStrengthConditionWidget({
    super.key,
    required this.isMatched,
    required this.conditionText,
  });

  final bool isMatched;
  final String conditionText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isMatched
            ? Icon(
          Icons.done,
          color: Theme.of(context).colorScheme.tertiary,
          size: 16,
        )
            : Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.onError,
          size: 16,
        ),
        SizedBox(width: 4,),
        Text(conditionText, style: Theme.of(context).textTheme.titleSmall!),
      ],
    );
  }
}