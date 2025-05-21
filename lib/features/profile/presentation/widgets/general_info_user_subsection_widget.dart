import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/horizontal_line_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/profile_image_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';

class GeneralInfoUserSubsectionWidget extends StatelessWidget {
  const GeneralInfoUserSubsectionWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userName,
    required this.mobileNo,
    required this.dateJoined,
    required this.profileImageUrl,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String mobileNo;
  final DateTime dateJoined;
  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
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
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24,
                    children: [
                      ProfileImageWidget(
                        hasCameraIcon: true,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$firstName $lastName',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userName.split('@').first,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                  ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.topCenter,
                    ),
                    iconSize: 20,
                    onPressed: () {
                      context.pushNamed(
                        AppRoutes.editProfile.name,
                        queryParameters: {'previousRoute': AppRoutes.profile.path},
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ))
              ],
            ),
          ),
          HorizontalLineWidget(),
          Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizationsContext.dateJoined.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(DateFormat('dd.MM.yyyy').format(dateJoined), style: Theme.of(context).textTheme.titleSmall)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizationsContext.mobileNo.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mobileNo,
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    )
                  ])),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizationsContext.email.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          )
        ],
      ),
    );
  }
}
