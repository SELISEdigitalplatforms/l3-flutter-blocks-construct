import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/dashboard/presentation/widgets/user_overview_section_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/dashboard/presentation/widgets/users_platform_section_widget.dart';

import '../../../../theme/app_colors.dart';
import '../../../common/presentation/widgets/app_elevated_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizationsContext.dashboard,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    AppElevatedButton(
                      onPressed: () {},
                      title: "",
                      foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      borderColor: AppColors.neutral90,
                      borderRadius: 6,
                      isUppercase: false,
                      leadingIcon: Icon(
                        size: 20,
                        Icons.sync,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    AppElevatedButton(
                      onPressed: () {},
                      title: "",
                      foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      borderRadius: 6,
                      isUppercase: false,
                      leadingIcon: Icon(
                        size: 20,
                        Icons.file_download_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16),
            OverviewSectionWidget(),
            SizedBox(height: 16),
            UsersPlatformSectionWidget(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
