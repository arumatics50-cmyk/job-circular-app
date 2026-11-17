import 'package:flutter/material.dart';
import '../models/job_circular.dart';
import '../services/job_service.dart';
import '../widgets/job_card.dart';
import '../widgets/category_chips.dart';
import 'circular_detail_screen.dart';
import 'exam_notices_screen.dart';
import 'bookmarks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> _categories = [
    'সকল চাকরি',
    'সরকারি চাকরি',
    'ব্যাংক জব',
    'রেলওয়ে',
    'ডিফেন্স',
  ];
  String _selectedCategory = 'সকল চাকরি';

  List<JobCircular> _allJobs = [];
  List<JobCircular> _displayedJobs = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchJobs();
  }

  void _fetchJobs() async {
    setState(() => _isLoading = true);
    final jobs = await JobService().getAllCirculars();
    setState(() {
      _allJobs = jobs;
      _isLoading = false;
      _applyFilter();
    });
  }

  void _applyFilter() {
    List<JobCircular> temp = _allJobs;
    if (_selectedCategory != 'সকল চাকরি') {
      temp = temp.where((j) => j.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      temp = temp.where((j) =>
          j.title.toLowerCase().contains(q) ||
          j.organization.toLowerCase().contains(q) ||
          j.qualification.toLowerCase().contains(q)).toList();
    }
    setState(() {
      _displayedJobs = temp;
    });
  }

  Widget _buildHomeFeed() {
    return RefreshIndicator(
      onRefresh: () async => _fetchJobs(),
      child: CustomScrollView(
        slivers: [
          // App Bar with Search Box
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 1,
            backgroundColor: Theme.of(context).primaryColor,
            title: const Row(
              children: [
                Icon(Icons.work_outline, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'চাকরির খবর (Job Circulars)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(66),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      _searchQuery = val;
                      _applyFilter();
                    },
                    decoration: InputDecoration(
                      hintText: 'পদ বা প্রতিষ্ঠানের নাম দিয়ে খুঁজুন...',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.search, size: 20, color: Colors.teal),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                _searchQuery = '';
                                _applyFilter();
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Category Chips Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CategoryChips(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onSelect: (cat) {
                  setState(() {
                    _selectedCategory = cat;
                    _applyFilter();
                  });
                },
              ),
            ),
          ),

          // Count & Notice Strip
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'মোট ${_displayedJobs.length} টি সার্কুলার পাওয়া গেছে',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '🔔 আপডেট প্রতিদিন',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.brown),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 6)),

          // Job Circulars List
          _isLoading
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              : _displayedJobs.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 60, color: Colors.grey[400]),
                            const SizedBox(height: 10),
                            const Text('কোনো সার্কুলার পাওয়া যায়নি', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final circular = _displayedJobs[index];
                          return JobCard(
                            circular: circular,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CircularDetailScreen(circular: circular),
                                ),
                              );
                            },
                          );
                        },
                        childCount: _displayedJobs.length,
                      ),
                    ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeFeed(),
          const ExamNoticesScreen(),
          const BookmarksScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) {
          setState(() => _currentIndex = idx);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'হোম',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'পরীক্ষার নোটিশ',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: 'বুকমার্কস',
          ),
        ],
      ),
    );
  }
}
