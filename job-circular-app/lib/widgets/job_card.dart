import 'package:flutter/material.dart';
import '../models/job_circular.dart';
import '../services/bookmark_service.dart';

class JobCard extends StatefulWidget {
  final JobCircular circular;
  final VoidCallback onTap;
  final VoidCallback? onBookmarkChanged;

  const JobCard({
    Key? key,
    required this.circular,
    required this.onTap,
    this.onBookmarkChanged,
  }) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = BookmarkService().isBookmarked(widget.circular.id);
  }

  void _toggleBookmark() async {
    final res = await BookmarkService().toggleBookmark(widget.circular.id);
    setState(() {
      _isBookmarked = res;
    });
    widget.onBookmarkChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.circular;
    final isUrgent = c.daysRemaining <= 3 && !c.isExpired;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isUrgent ? Colors.red.withOpacity(0.3) : Colors.grey.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Org + Category + Bookmark
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        c.category == 'ব্যাংক জব'
                            ? Icons.account_balance
                            : Icons.business_center,
                        color: Theme.of(context).primaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.organization,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          c.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: _isBookmarked ? Colors.teal : Colors.grey,
                    ),
                    onPressed: _toggleBookmark,
                    splashRadius: 20,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Qualification Preview
              Row(
                children: [
                  const Icon(Icons.school_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      c.qualification,
                      style: TextStyle(fontSize: 12.5, color: Colors.grey[800]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Vacancy / Post Count
              Row(
                children: [
                  const Icon(Icons.people_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    'পদসংখ্যা: ${c.postCount}',
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Bottom Row: Category Chip & Deadline Countdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      c.category,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isUrgent
                          ? Colors.red.withOpacity(0.12)
                          : Colors.teal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: isUrgent ? Colors.red : Colors.teal[800],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          c.remainingText,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: isUrgent ? Colors.red : Colors.teal[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
