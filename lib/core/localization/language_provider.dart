import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/constants/core_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/storage/i_local_storage_service.dart';

final sl = GetIt.instance;

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final localStorageService = sl<ILocalStorageService>();
    final langCode =
        await localStorageService.getData(CoreConstants.languageCode) ?? 'en';
    state = Locale(langCode);
  }

  Future<void> changeLocale(Locale newLocale) async {
    state = newLocale;
    final localStorageService = sl<ILocalStorageService>();
    await localStorageService.setData(
        CoreConstants.languageCode, newLocale.languageCode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);
