import 'dart:async';

import 'package:l3_flutter_selise_blocksconstruct/core/di/contracts/i_injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/data/repos/auth_repo_impl.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/repos/auth_repo.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/usecases/login_usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/usecases/logout_usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/data/repos/profile_repo.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/repos/i_profile_repo.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/usecases/profile_usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/usecases/update_profile_usecase.dart';

class InjectionContainer implements IInjectionContainer {
  @override
  Future<void> init() async {
    sl
      ..registerLazySingleton(() => LoginUseCase(sl()))
      ..registerFactory(() => LogoutUseCase(sl()))
      ..registerLazySingleton(() => ForgotPasswordUseCase(sl()))
      ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
      ..registerLazySingleton(() => ResetPasswordUseCase(sl()));

    sl
      ..registerLazySingleton<IProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(sl()))
      ..registerLazySingleton<IProfileRepo>(() => ProfileRepo(sl()))
      ..registerLazySingleton(() => ProfileUseCase(sl()))
      ..registerLazySingleton(() => ChangePasswordUseCase(sl()))
      ..registerLazySingleton(() => UpdateProfileUsecase(sl()));
  }
}
