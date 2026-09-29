import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteManager {
  FavoriteManager._();

  static final FavoriteManager instance = FavoriteManager._();
  static const String _storageKey = 'favorite_culinary_ids';

  final ValueNotifier<Set<int>> favoritesNotifier =
      ValueNotifier<Set<int>>(<int>{});
  SharedPreferences? _preferences;

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    final savedIds = _preferences?.getStringList(_storageKey) ?? <String>[];
    favoritesNotifier.value = savedIds
        .map(int.tryParse)
        .whereType<int>()
        .toSet();
  }

  Future<void> toggleFavorite(int culinaryId) async {
    final favorites = Set<int>.from(favoritesNotifier.value);
    if (!favorites.add(culinaryId)) {
      favorites.remove(culinaryId);
    }
    favoritesNotifier.value = favorites;
    await _preferences?.setStringList(
      _storageKey,
      favorites.map((id) => id.toString()).toList(),
    );
  }
}