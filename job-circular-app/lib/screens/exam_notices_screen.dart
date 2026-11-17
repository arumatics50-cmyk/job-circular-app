import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/job_circular.dart';
import '../services/job_service.dart';
import 'circular_detail_screen.dart';

class ExamNoticesScreen extends StatefulWidget {
  const ExamNoticesScreen({Key? key}) : super(key: key);

  @override
  State<ExamNoticesScreen> createState() => _ExamNoticesScreenState();
}

class _ExamNoticesScreenState extends State<ExamNoticesScreen> {
  List<JobCircular> _notices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotices();
  }

  void _loadNotices() async {
    final list = await JobService().getExamNotices();
    setState(() {
      _notices = list;
      _isLoading = false;
    });
  }

  void _openLink(String? urlStr) async {
    if (urlStr == null || urlStr.isEmpty) return;
    final Uri url = Uri.parse(urlStr);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('পরীক্ষার সময়সূচি ও নোটিশ'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notices.isEmpty
              ? const Center(child: Text('বর্তমানে কোনো পরীক্ষার নোটিশ নেই'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: _notices.length,
                  itemBuilder: (context, index) {
                    final item = _notices[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item.category,
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                                  ),
                                ),
                                const Spacer(),
                                if (item.resultStatus != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      '🏆 রেজাল্ট প্রকাশিত',
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.title,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.organization,
                              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                            ),
                            const Divider(height: 20),
                            if (item.examDate != null)
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month, size: 16, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(
                                    'পরীক্ষার তারিখ: ${item.examDate}',
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            if (item.admitCardStatus != null) ...[
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.confirmation_number_outlined, size: 16, color: Colors.orange),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'প্রবেশপত্র: ${item.admitCardStatus}',
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => CircularDetailScreen(circular: item)),
                                    );
                                  },
                                  child: const Text('সার্কুলার দেখুন'),
                                ),
                                const SizedBox(width: 8),
                                if (item.admitCardUrl != null)
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    onPressed: () => _openLink(item.admitCardUrl),
                                    icon: const Icon(Icons.download, size: 16),
                                    label: const Text('অ্যাডমিট কার্ড'),
                                  )
                                else if (item.resultUrl != null)
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    onPressed: () => _openLink(item.resultUrl),
                                    icon: const Icon(Icons.assignment_turned_in, size: 16),
                                    label: const Text('রেজাল্ট দেখুন'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
