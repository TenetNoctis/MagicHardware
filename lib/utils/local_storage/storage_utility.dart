import 'package:get_storage/get_storage.dart';

/// A class for managing local storage using GetStorage.
///
/// This class provides a singleton instance to interact with different storage buckets.
/// It supports initializing different buckets, saving, reading, removing data, and clearing the storage.
class MagicLocalStorage {
  late GetStorage _storage;
  String? _currentBucket;

  static MagicLocalStorage? _instance;
  static final Map<String, GetStorage> _storages = {};
  static bool _isInitializing = false;

  MagicLocalStorage._internal();

  /// Returns the singleton instance of [MagicLocalStorage].
  factory MagicLocalStorage.instance() {
    _instance ??= MagicLocalStorage._internal();
    return _instance!;
  }

  /// Initializes a storage bucket with the given [bucketName].
  ///
  /// This method must be called before any other storage operations.
  /// It handles concurrent initializations and ensures that a bucket is only initialized once.
  static Future<void> init(String bucketName) async {
    _instance ??= MagicLocalStorage._internal();

    while (_isInitializing) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    if (_instance!._currentBucket == bucketName &&
        _storages.containsKey(bucketName)) {
      return;
    }

    _isInitializing = true;

    try {
      if (!_storages.containsKey(bucketName)) {
        await GetStorage.init(bucketName);
        _storages[bucketName] = GetStorage(bucketName);
      }

      _instance!._storage = _storages[bucketName]!;
      _instance!._currentBucket = bucketName;
    } finally {
      _isInitializing = false;
    }
  }

  /// Saves data to the currently initialized storage bucket.
  ///
  /// - [key]: The key to store the data under.
  /// - [value]: The data to be saved.
  ///
  /// Throws an exception if the storage is not initialized.
  Future<void> saveData<T>(String key, T value) async {
    if (_currentBucket == null) {
      throw Exception('Storage not initialized. Call init() first.');
    }
    await _storage.write(key, value);
  }

  /// Reads data from the currently initialized storage bucket.
  ///
  /// - [key]: The key of the data to be read.
  ///
  /// Returns the data of type [T] or null if the key does not exist.
  /// Throws an exception if the storage is not initialized.
  T? readData<T>(String key) {
    if (_currentBucket == null) {
      throw Exception('Storage not initialized. Call init() first.');
    }
    return _storage.read<T>(key);
  }

  /// Removes data from the currently initialized storage bucket.
  ///
  /// - [key]: The key of the data to be removed.
  ///
  /// Throws an exception if the storage is not initialized.
  Future<void> removeData(String key) async {
    if (_currentBucket == null) {
      throw Exception('Storage not initialized. Call init() first.');
    }
    await _storage.remove(key);
  }

  /// Clears all data from the currently initialized storage bucket.
  ///
  /// Throws an exception if the storage is not initialized.
  Future<void> clearAll() async {
    if (_currentBucket == null) {
      throw Exception('Storage not initialized. Call init() first.');
    }
    await _storage.erase();
  }

  /// Resets the local storage by clearing the current bucket and all stored instances.
  static void reset() {
    _instance?._currentBucket = null;
    _storages.clear();
  }

  /// Returns `true` if a storage bucket has been initialized.
  bool get isInitialized => _currentBucket != null;

  /// Returns the name of the currently initialized bucket, or null if not initialized.
  String? get currentBucket => _currentBucket;
}
