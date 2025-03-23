import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/presentation/widgets/app_elevated_button.dart';
import '../../domain/models/device_item_model.dart';

class DeviceDetailsTile extends StatefulWidget {
  final DeviceItemModel device;

  const DeviceDetailsTile({super.key, required this.device});

  @override
  DeviceDetailsTileState createState() => DeviceDetailsTileState();
}

class DeviceDetailsTileState extends State<DeviceDetailsTile> {
  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;

    return Column(
      children: [
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Icon(
                  widget.device.icon,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Text(widget.device.name, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          leading: Icon(
            widget.device.isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          onTap: () {
            setState(() {
              widget.device.isExpanded = !widget.device.isExpanded;
            });
          },
        ),
        if (widget.device.isExpanded) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizationsContext.sessions,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "${widget.device.sessions}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizationsContext.lastAccessedOn,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.device.lastAccessed,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                AppElevatedButton(
                  onPressed: () {},
                  title: localizationsContext.remove,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  borderColor: AppColors.neutral90,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  borderRadius: 6,
                  height: 32,
                  isUppercase: false,
                )
              ],
            ),
          ),
        ],
      ],
    );
  }
}
