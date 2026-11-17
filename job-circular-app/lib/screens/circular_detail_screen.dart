import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../models/job_circular.dart';
import '../services/bookmark_service.dart';
import 'image_viewer_screen.dart';

class CircularDetailScreen extends StatefulWidget {
  final JobCircular circular;

  const CircularDetailScreen({Key? key, required this.circular}) : super(key: key);

  @override
  State<CircularDetailScreen> createState() => _CircularDetailScreenState();
}

class _CircularDetailScreenState extends State<CircularDetailScreen> {
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res ? 'বুকমার্কে সংরক্ষণ করা হয়েছে' : 'বুকমার্ক থেকে মুছে ফেলা হয়েছে'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _applyNow() async {
    final Uri url = Uri.parse(widget.circular.applyUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('আবেদন লিংক ওপেন করা যায়নি')),
      );
    }
  }

  void _shareJob() {
    final c = widget.circular;
    final text = '📌 ${c.title}\n🏢 প্রতিষ্ঠান: ${c.organization}\n👥 পদসংখ্যা: ${c.postCount}\n⏰ শেষ তারিখ: ${DateFormat('dd MMMM yyyy').format(c.deadline)}\n🔗 আবেদনের লিংক: ${c.applyUrl}';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.circular;
    final dateFormat = DateFormat('dd MMMM, yyyy');
    final isUrgent = c.daysRemaining <= 3 && !c.isExpired;

    return Scaffold(
      appBar: AppBar(
        title: const Text('চাকরির বিস্তারিত'),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? Colors.amber[300] : Colors.white,
            ),
            onPressed: _toggleBookmark,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareJob,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Organization Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).primaryColor.withOpacity(0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      c.category,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    c.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.3),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.organization,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            // Deadline Warning Banner
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUrgent ? Colors.red.withOpacity(0.08) : Colors.teal.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isUrgent ? Colors.red.withOpacity(0.3) : Colors.teal.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.timer_outlined, color: isUrgent ? Colors.red : Colors.teal[800]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'আবেদনের শেষ তারিখ: ${dateFormat.format(c.deadline)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                            color: isUrgent ? Colors.red[900] : Colors.teal[900],
                          ),
                        ),
                        Text(
                          c.remainingText,
                          style: TextStyle(
                            fontSize: 12,
                            color: isUrgent ? Colors.red[700] : Colors.teal[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Key Info Summary Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                color: Colors.grey.withOpacity(0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildInfoRow('👥 পদসংখ্যা', c.postCount),
                      const Divider(height: 18),
                      _buildInfoRow('💰 বেতন স্কেল', c.salary),
                      const Divider(height: 18),
                      _buildInfoRow('🎓 শিক্ষাগত যোগ্যতা', c.qualification),
                      const Divider(height: 18),
                      _buildInfoRow('🎂 বয়সসীমা', c.ageLimit),
                      const Divider(height: 18),
                      _buildInfoRow('📅 প্রকাশের তারিখ', dateFormat.format(c.publishDate)),
                      if (c.examDate != null) ...[
                        const Divider(height: 18),
                        _buildInfoRow('📝 পরীক্ষার তারিখ', c.examDate!),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Job Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('চাকরির সংক্ষিপ্ত বিবরণ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    c.description,
                    style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 18),
                  const Text('আবেদনের শর্তাবলী', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...c.requirements.map(
                    (req) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(req, style: TextStyle(fontSize: 13.5, height: 1.4, color: Colors.grey[800])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Official Circular Image Preview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('মূল সার্কুলার কপি (পত্রিকার বিজ্ঞাপন)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ImageViewerScreen(imageUrl: c.circularImageUrl, title: c.title),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            c.circularImageUrl,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.zoom_in, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'ক্লিক করে জুম করে দেখুন',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Fixed Bottom Action Button
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, -3)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: c.isExpired ? null : _applyNow,
                icon: const Icon(Icons.open_in_browser),
                label: Text(
                  c.isExpired ? 'আবেদনের সময় শেষ' : 'অনলাইনে আবেদন করুন (Apply Now)',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        ),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 13, color: Colors.grey[800], height: 1.3)),
        ),
      ],
    );
  }
}
