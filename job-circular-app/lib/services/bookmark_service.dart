import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static final BookmarkService _instance = BookmarkService._internal();
  factory BookmarkService() => _instance;
  BookmarkService._internal();

  static const String _key = 'bookmarked_jobs';
  final Set<String> _bookmarkedIds = {};

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_key) ?? [];
      _bookmarkedIds.addAll(list);
    } catch (_) {}
  }

  bool isBookmarked(String id) {
    return _bookmarkedIds.contains(id);
  }

  Future<bool> toggleBookmark(String id) async {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, _bookmarkedIds.toList());
    } catch (_) {}
    return isBookmarked(id);
  }

  List<String> getBookmarkedIds() {
    return _bookmarkedIds.toList();
  }
}
