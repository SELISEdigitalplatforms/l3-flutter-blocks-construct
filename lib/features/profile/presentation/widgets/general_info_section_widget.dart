import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/profile_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/exception_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/widgets/general_info_account_security_subsection_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/widgets/general_info_section_shimmer_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/widgets/general_info_user_subsection_widget.dart';

class GeneralInfoSectionWidget extends ConsumerWidget {
  const GeneralInfoSectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileDetails = ref.watch(profileProvider);

    if (profileDetails.isLoading) {
      return Column(
        spacing: 16,
        children: [
          GeneralInfoSectionShimmerWidget(
            height: 220,
          ),
          GeneralInfoSectionShimmerWidget(
            height: 220,
          ),
        ],
      );
    } else if (profileDetails.isFailure) {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: ExceptionWidget(
          description: profileDetails.message ?? '',
        ),
      );
    } else {
      return Column(
        children: [
          GeneralInfoUserSubsectionWidget(
            firstName: profileDetails.profileData?.data?.firstName ?? '',
            lastName: profileDetails.profileData?.data?.lastName ?? '',
            email: profileDetails.profileData?.data?.email ?? '',
            userName: profileDetails.profileData?.data?.userName ?? '',
            mobileNo: profileDetails.profileData?.data?.phoneNumber ?? '',
            dateJoined:
                profileDetails.profileData?.data?.createdDate ?? DateTime.now(),
            profileImageUrl:
                profileDetails.profileData?.data?.profileImageUrl ?? '',
          ),
          GeneralInfoAccountSecuritySubsectionWidget(
            isTwoFactorAuthenticationEnabled:
                profileDetails.profileData?.data?.mfaEnabled ?? false,
          )
        ],
      );
    }
  }
}
