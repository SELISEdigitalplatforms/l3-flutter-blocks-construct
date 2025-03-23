import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/profile_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/image_network_widget.dart';

class ProfileImageWidget extends ConsumerWidget {
  const ProfileImageWidget({
    super.key,
    this.width = 64,
    this.height = 64,
    this.hasCameraIcon = false,
    this.imageUrl,
  });

  final double width;
  final double height;
  final bool hasCameraIcon;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImageUrl = imageUrl ?? ref.watch(profileProvider).profileData?.data?.profileImageUrl ?? '';
    return hasCameraIcon
        ? _getProfileContainerWithCameraIcon(context, profileImageUrl)
        : _getProfileContainer(context, profileImageUrl);
  }

  Widget _getProfileContainer(BuildContext context, String profileImageUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondaryContainer,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(76),
            blurRadius: 2,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipOval(
        child: SizedBox(
          width: width,
          height: height,
          child: ImageNetworkWidget(
            profileImageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _getProfileContainerWithCameraIcon(BuildContext context, String profileImageUrl) {
    return Stack(
      children: [
        _getProfileContainer(context, profileImageUrl),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(76),
                      blurRadius: 1.25,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ]),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
