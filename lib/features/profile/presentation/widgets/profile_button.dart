import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/profile_image_widget.dart';

class ProfileButton extends ConsumerWidget {
  final GlobalKey<ScaffoldState>? _scaffoldKey;

  const ProfileButton(this._scaffoldKey, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          _scaffoldKey?.currentState?.openEndDrawer();
        },
        child: ProfileImageWidget(
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
