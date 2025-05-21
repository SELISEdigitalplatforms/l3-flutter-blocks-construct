import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_custom_appbar.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/profile_section_types.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/widgets/activity_log_section_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/widgets/devices_section_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/widgets/general_info_section_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.previousRoute});

  final AppRoutes previousRoute;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileSectionTypes _selectedSection = ProfileSectionTypes.generalInfo;

  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppCustomAppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.instance.navigation
                    .goNamed(widget.previousRoute.name);
              },
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(
                  localizationsContext.myProfile,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Container(
                height: 42,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSection = ProfileSectionTypes.generalInfo;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: ShapeDecoration(
                            color:
                                _getSectionColor(ProfileSectionTypes.generalInfo),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Text(
                            localizationsContext.generalInfo,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: _getTextColor(
                                          ProfileSectionTypes.generalInfo),
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSection = ProfileSectionTypes.devices;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: ShapeDecoration(
                            color: _getSectionColor(ProfileSectionTypes.devices),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Text(
                            localizationsContext.devices,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      _getTextColor(ProfileSectionTypes.devices),
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSection = ProfileSectionTypes.activityLog;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: ShapeDecoration(
                            color:
                                _getSectionColor(ProfileSectionTypes.activityLog),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Text(
                            localizationsContext.activityLog,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: _getTextColor(
                                          ProfileSectionTypes.activityLog),
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _getProfileSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getProfileSection() {
    switch (_selectedSection) {
      case ProfileSectionTypes.generalInfo:
        return GeneralInfoSectionWidget();
      case ProfileSectionTypes.devices:
        return DevicesSectionWidget();
      case ProfileSectionTypes.activityLog:
        return ActivityLogSectionWidget();
    }
  }

  Color _getSectionColor(ProfileSectionTypes section) {
    return _selectedSection == section
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.secondaryContainer;
  }

  Color _getTextColor(ProfileSectionTypes section) {
    return _selectedSection == section
        ? Theme.of(context).colorScheme.onSurface
        : Theme.of(context).colorScheme.onSecondaryContainer;
  }
}
