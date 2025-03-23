import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import 'donut_chart_widget.dart';

class UsersPlatformSectionWidget extends StatefulWidget {
  const UsersPlatformSectionWidget({super.key});

  @override
  State<UsersPlatformSectionWidget> createState() => _UsersPlatformSectionWidgetState();
}

class _UsersPlatformSectionWidgetState extends State<UsersPlatformSectionWidget> {
  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;

    final dataMap = {
      "Windows": 4500.0,
      "Mac": 3100.0,
      "iOS": 1700.0,
      "Android": 1230.0,
    };
    final colorMap = {
      "Windows": AppColors.purple20,
      "Mac": AppColors.purple50,
      "iOS": AppColors.purple80,
      "Android": AppColors.purple100,
    };

    String selectedPeriod = "This month";
    final List<String> periods = ["This month"];
    final double total = 10530;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(10),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizationsContext.usersByPlatform,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutral90),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  value: selectedPeriod,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  underline: Container(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedPeriod = newValue;
                      });
                    }
                  },
                  items: periods.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: Theme.of(context).textTheme.titleSmall),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                DonutChart(
                  total: total,
                  dataMap: dataMap,
                  colorMap: colorMap,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localizationsContext.total,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                    ),
                    Text(
                      "${total.toInt()}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Wrap(
              spacing: 20.0,
              runSpacing: 8.0,
              children: dataMap.keys.map((platform) {
                final color = colorMap[platform] ?? AppColors.neutral90;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: ShapeDecoration(
                          color: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      platform,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
