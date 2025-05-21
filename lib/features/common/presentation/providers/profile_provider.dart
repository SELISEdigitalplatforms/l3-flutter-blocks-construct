import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/logger/app_logging.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/usecases/profile_usecase.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(
    sl(),
  ),
);

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileUseCase _profileUseCase;

  ProfileNotifier(this._profileUseCase) : super(ProfileState()) {
    getData();
  }

  Future<void> getData() async {
    state = state.copyWith(isLoading: true);
    final results = await _profileUseCase();

    results.fold(
      (failure) {
        logger.e(error: failure, message: failure.message);
        state = ProfileState(isLoading: false, message: failure.message, isFailure: true);
        return false;
      },
      (response) {
        state = ProfileState(isLoading: false, profileData: response);
        return true;
      },
    );
  }
}

class ProfileState {
  final bool isLoading;
  final bool isFailure;
  final String? message;
  final ProfileModel? profileData;

  ProfileState({
    this.isLoading = false,
    this.isFailure = false,
    this.message,
    this.profileData,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isFailure,
    String? message,
    ProfileModel? profileData,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isFailure: isFailure ?? this.isFailure,
      message: message ?? this.message,
      profileData: profileData ?? this.profileData,
    );
  }
}
