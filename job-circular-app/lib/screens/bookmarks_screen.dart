import 'package:flutter/material.dart';
import '../models/job_circular.dart';
import '../services/job_service.dart';
import '../services/bookmark_service.dart';
import '../widgets/job_card.dart';
import 'circular_detail_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<JobCircular> _bookmarkedCirculars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  void _loadBookmarks() async {
    final all = await JobService().getAllCirculars();
    final bookmarkedIds = BookmarkService().getBookmarkedIds();
    setState(() {
      _bookmarkedCirculars = all.where((c) => bookmarkedIds.contains(c.id)).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('সংরক্ষিত সার্কুলার (Bookmarks)'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookmarkedCirculars.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_border, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      const Text(
                        'কোনো সংরক্ষিত সার্কুলার নেই',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'পছন্দের সার্কুলারে বুকমার্ক আইকনে ক্লিক করে সংরক্ষণ করুন',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _bookmarkedCirculars.length,
                  itemBuilder: (context, index) {
                    final item = _bookmarkedCirculars[index];
                    return JobCard(
                      circular: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CircularDetailScreen(circular: item)),
                        ).then((_) => _loadBookmarks());
                      },
                      onBookmarkChanged: _loadBookmarks,
                    );
                  },
                ),
    );
  }
}
