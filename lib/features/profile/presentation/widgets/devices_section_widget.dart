import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/presentation/widgets/app_elevated_button.dart';
import '../../domain/models/device_item_model.dart';
import 'device_details_tile_widget.dart';

class DevicesSectionWidget extends StatefulWidget {
  const DevicesSectionWidget({super.key});

  @override
  DevicesSectionWidgetState createState() => DevicesSectionWidgetState();
}

class DevicesSectionWidgetState extends State<DevicesSectionWidget> {
  final List<DeviceItemModel> devices = [
    DeviceItemModel(name: "iPhone 13 Pro", sessions: 12, lastAccessed: "10/01/2025", icon: Icons.phone_android_sharp),
    DeviceItemModel(name: "iMac19,1", sessions: 8, lastAccessed: "08/01/2025", icon: Icons.desktop_windows_rounded),
    DeviceItemModel(name: "Windows", sessions: 5, lastAccessed: "07/01/2025", icon: Icons.desktop_windows_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.secondaryContainer),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizationsContext.myDevices,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              AppElevatedButton(
                onPressed: () {},
                title: localizationsContext.removeAll,
                foregroundColor: Theme.of(context).colorScheme.onError,
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                height: 32,
                isUppercase: false,
                leadingIcon: Icon(
                  size: 16,
                  Icons.delete_outline_rounded,
                  color: Theme.of(context).colorScheme.onError,
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: devices.length,
            itemBuilder: (context, index) {
              return DeviceDetailsTile(device: devices[index]);
            },
          ),
        ],
      ),
    );
  }
}
