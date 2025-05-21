import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_response_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/usecases/update_profile_usecase.dart';

final updateProfileProvider =
    StateNotifierProvider<UpdateProfileNotifier, UpdateProfileState>(
  (ref) => UpdateProfileNotifier(sl()),
);

class UpdateProfileNotifier extends StateNotifier<UpdateProfileState> {
  final UpdateProfileUsecase _updateProfileUsecase;

  UpdateProfileNotifier(
    this._updateProfileUsecase,
  ) : super(UpdateProfileState());

  Future<bool> updateProfile(UpdateProfileModel updateProfileData) async {
    state = UpdateProfileState(isLoading: true);

    final results = await _updateProfileUsecase(updateProfileData);

    return results.fold(
      (failure) {
        state = UpdateProfileState(isFailure: true, message: failure.message);
        return false;
      },
      (response) {
        state = UpdateProfileState(
          updateProfileResponseData: response,
        );
        return true;
      },
    );
  }
}

class UpdateProfileState {
  final bool isLoading;
  final bool isFailure;
  final String? message;
  final UpdateProfileResponseModel? updateProfileResponseData;

  UpdateProfileState({
    this.isLoading = false,
    this.isFailure = false,
    this.message,
    this.updateProfileResponseData,
  });
}
