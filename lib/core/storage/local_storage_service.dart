import 'package:shared_preferences/shared_preferences.dart';
import 'i_local_storage_service.dart';

class SharedPreferencesService implements ILocalStorageService {
  final SharedPreferences sharedPreferences;

  SharedPreferencesService(this.sharedPreferences);

  @override
  Future<String?> getData(String key) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<bool> setData(String key, String data) async {
    return sharedPreferences.setString(key, data);
  }

  @override
  Future<bool> remove(String key) async {
    return sharedPreferences.remove(key);
  }

  @override
  Future<bool?> clearAllData() async {
    return sharedPreferences.clear();
  }
}
