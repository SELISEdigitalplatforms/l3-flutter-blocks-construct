import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/blocks_auth_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/blocks_token_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_auth_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_token_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/contracts/i_injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/dio_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/storage/i_local_storage_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class InjectionContainer implements IInjectionContainer {
  @override
  Future<void> init() async {
    const secureStorage = FlutterSecureStorage();
    final sharedPreferences = await SharedPreferences.getInstance();
    final localStorageService = SharedPreferencesService(sharedPreferences);

    sl.registerLazySingleton<ILocalStorageService>(() => localStorageService);
    sl.registerLazySingleton<DioService>(
      () => DioService(),
    );
    sl.registerLazySingleton(() => secureStorage);
    sl.registerLazySingleton<ITokenService>(
        () => BlocksTokenService(sl(), sl()));
    sl.registerLazySingleton<IAuthService>(
        () => BlocksAuthService(sl(), sl(), sl()));
  }
}
