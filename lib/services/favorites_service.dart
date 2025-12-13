import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const key = "favorite_recipes";

  static Future<void> addFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(key) ?? [];
    if (!existing.contains(id)) {
      existing.add(id);
      await prefs.setStringList(key, existing);
    }
  }

  static Future<void> removeFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(key) ?? [];
    existing.remove(id);
    await prefs.setStringList(key, existing);
  }

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static Future<bool> isFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(key) ?? [];
    return existing.contains(id);
  }
}
