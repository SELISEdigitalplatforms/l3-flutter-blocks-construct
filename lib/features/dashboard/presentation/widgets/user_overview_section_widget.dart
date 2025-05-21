import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../theme/app_colors.dart';
import 'dashboard_overview_tile_widget.dart';

class OverviewSectionWidget extends StatefulWidget {
  const OverviewSectionWidget({super.key});

  @override
  State<OverviewSectionWidget> createState() => _OverviewSectionWidgetState();
}

class _OverviewSectionWidgetState extends State<OverviewSectionWidget> {
  @override
  Widget build(BuildContext context) {
    String selectedPeriod = "This month";
    final List<String> periods = ["This month"];
    final localizationsContext = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        shadows: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(10),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizationsContext.overview,
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
          const SizedBox(height: 24),
          DashboardOverviewTileWidget(
            title: "Total users",
            value: "10,000",
            growth: "+2.5%",
            image: AssetHelper.users,
            trending: true,
            duration: 'month',
          ),
          const SizedBox(height: 24),
          DashboardOverviewTileWidget(
            title: "Total active users",
            value: "7,000",
            growth: "-5%",
            image: AssetHelper.activeUsers,
            trending: false,
            duration: 'month',
          ),
          const SizedBox(height: 24),
          DashboardOverviewTileWidget(
            title: "New sign-ups",
            value: "1,200",
            growth: "+8%",
            image: AssetHelper.newUser,
            trending: true,
            duration: 'month',
          ),
        ],
      ),
    );
  }
}
