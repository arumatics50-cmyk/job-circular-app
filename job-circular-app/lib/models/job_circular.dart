class JobCircular {
  final String id;
  final String title;
  final String organization;
  final String category; // 'সরকারি চাকরি', 'ব্যাংক জব', 'ডিফেন্স', 'রেলওয়ে', 'শিক্ষক নিয়োগ'
  final String postCount;
  final String salary;
  final String qualification;
  final String ageLimit;
  final DateTime publishDate;
  final DateTime deadline;
  final String circularImageUrl;
  final String circularPdfUrl;
  final String applyUrl;
  final String? examDate;
  final String? admitCardStatus;
  final String? admitCardUrl;
  final String? resultStatus;
  final String? resultUrl;
  final String description;
  final List<String> requirements;
  final bool isFeatured;
  final String logoUrl;

  JobCircular({
    required this.id,
    required this.title,
    required this.organization,
    required this.category,
    required this.postCount,
    required this.salary,
    required this.qualification,
    required this.ageLimit,
    required this.publishDate,
    required this.deadline,
    required this.circularImageUrl,
    this.circularPdfUrl = '',
    required this.applyUrl,
    this.examDate,
    this.admitCardStatus,
    this.admitCardUrl,
    this.resultStatus,
    this.resultUrl,
    required this.description,
    required this.requirements,
    this.isFeatured = false,
    this.logoUrl = '',
  });

  bool get isExpired => DateTime.now().isAfter(deadline);

  int get daysRemaining {
    final now = DateTime.now();
    if (isExpired) return 0;
    return deadline.difference(now).inDays;
  }

  String get remainingText {
    if (isExpired) return 'আবেদনের সময় শেষ';
    final days = daysRemaining;
    if (days == 0) return 'আজই শেষ দিন!';
    return '$days দিন বাকি';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'organization': organization,
      'category': category,
      'postCount': postCount,
      'salary': salary,
      'qualification': qualification,
      'ageLimit': ageLimit,
      'publishDate': publishDate.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'circularImageUrl': circularImageUrl,
      'circularPdfUrl': circularPdfUrl,
      'applyUrl': applyUrl,
      'examDate': examDate,
      'admitCardStatus': admitCardStatus,
      'admitCardUrl': admitCardUrl,
      'resultStatus': resultStatus,
      'resultUrl': resultUrl,
      'description': description,
      'requirements': requirements,
      'isFeatured': isFeatured,
      'logoUrl': logoUrl,
    };
  }

  factory JobCircular.fromMap(Map<String, dynamic> map) {
    return JobCircular(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      organization: map['organization'] ?? '',
      category: map['category'] ?? 'সরকারি চাকরি',
      postCount: map['postCount'] ?? '',
      salary: map['salary'] ?? '',
      qualification: map['qualification'] ?? '',
      ageLimit: map['ageLimit'] ?? '',
      publishDate: DateTime.tryParse(map['publishDate'] ?? '') ?? DateTime.now(),
      deadline: DateTime.tryParse(map['deadline'] ?? '') ?? DateTime.now().add(const Duration(days: 15)),
      circularImageUrl: map['circularImageUrl'] ?? '',
      circularPdfUrl: map['circularPdfUrl'] ?? '',
      applyUrl: map['applyUrl'] ?? '',
      examDate: map['examDate'],
      admitCardStatus: map['admitCardStatus'],
      admitCardUrl: map['admitCardUrl'],
      resultStatus: map['resultStatus'],
      resultUrl: map['resultUrl'],
      description: map['description'] ?? '',
      requirements: List<String>.from(map['requirements'] ?? []),
      isFeatured: map['isFeatured'] ?? false,
      logoUrl: map['logoUrl'] ?? '',
    );
  }
}
