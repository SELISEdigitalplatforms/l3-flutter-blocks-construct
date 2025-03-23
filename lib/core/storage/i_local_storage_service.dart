abstract class ILocalStorageService {
  Future<String?> getData(String key);
  Future<bool> setData(String key, String data);
  Future<bool> remove(String key);
  Future<bool?> clearAllData();
}
