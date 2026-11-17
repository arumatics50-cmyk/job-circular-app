import '../models/job_circular.dart';

class JobService {
  static final JobService _instance = JobService._internal();
  factory JobService() => _instance;
  JobService._internal();

  // In-memory / Mock dataset of authentic Bangladesh Job Circulars
  final List<JobCircular> _circulars = [
    JobCircular(
      id: 'job-01',
      title: 'সহকারী পরিচালক (সাধারণ শাখা) নিয়োগ বিজ্ঞপ্তি ২০২৪',
      organization: 'বাংলাদেশ ব্যাংক (Bangladesh Bank)',
      category: 'ব্যাংক জব',
      postCount: '২২৫ জন',
      salary: 'জাতীয় বেতন স্কেল ২০১৫ অনুযায়ী ২২,০০০ - ৫৩,০৬০ টাকা (গ্রেড-৯)',
      qualification: 'কোনো স্বীকৃত বিশ্ববিদ্যালয় হতে ৪ বছর মেয়াদী স্নাতক বা স্নাতকোত্তর ডিগ্রি (কমপক্ষে ২টি প্রথম বিভাগ/শ্রেণী)',
      ageLimit: '২১ থেকে ৩০ বছর (মুক্তিযোদ্ধা কোটায় ৩২ বছর)',
      publishDate: DateTime.now().subtract(const Duration(days: 3)),
      deadline: DateTime.now().add(const Duration(days: 18)),
      circularImageUrl: 'https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=1200&q=80',
      applyUrl: 'https://erecruitment.bb.org.bd',
      examDate: '১৫ ডিসেম্বর ২০২৪ (সম্ভাব্য)',
      admitCardStatus: 'অ্যাডমিট কার্ড প্রকাশ শীঘ্রই',
      description: 'বাংলাদেশ ব্যাংকের সহকারী পরিচালক (জেনারেল) পদে ২২৫ জন নিয়োগের জন্য বাংলাদেশি নাগরিকদের কাছ থেকে দরখাস্ত আহ্বান করা হচ্ছে। নির্বাচিত প্রার্থীরা সরকারের গ্রেড-৯ স্কেলে বেতন-ভাতা পাবেন।',
      requirements: [
        'স্বীকৃত বিশ্ববিদ্যালয় হতে যেকোনো বিষয়ে ৪ বছর মেয়াদী স্নাতক/স্নাতকোত্তর',
        'এসএসসি ও তদূর্ধ্ব পর্যায়ে কমপক্ষে ২টিতে ১ম বিভাগ বা সমমানের সিজিপিএ',
        'তৃতীয় বিভাগ/শ্রেণী গ্রহণযোগ্য নয়',
        'অনলাইনে আবেদন ফি ২০০ টাকা বাংলাদেশ ব্যাংকের রিক্রুটমেন্ট পোর্টালের মাধ্যমে প্রদান করতে হবে'
      ],
      isFeatured: true,
      logoUrl: 'https://upload.wikimedia.org/wikipedia/en/thumb/7/77/Bangladesh_Bank_Logo.svg/1200px-Bangladesh_Bank_Logo.svg.png',
    ),
    JobCircular(
      id: 'job-02',
      title: '৪৭তম বিসিএস পরীক্ষা ২০২৪ এর বিজ্ঞপ্তি (ক্যাডার ও নন-ক্যাডার)',
      organization: 'বাংলাদেশ সরকারি কর্ম কমিশন (BPSC)',
      category: 'সরকারি চাকরি',
      postCount: '৩,৪৮৭ জন',
      salary: 'জাতীয় বেতন স্কেল ২০১৫ অনুযায়ী গ্রেড-৯ (২২,০০০ - ৫৩,০৬০ টাকা)',
      qualification: 'স্বীকৃত বিশ্ববিদ্যালয় হতে ৪ বছর মেয়াদী স্নাতক (সম্মান) বা সমমানের ডিগ্রি',
      ageLimit: '২১ থেকে ৩২ বছর',
      publishDate: DateTime.now().subtract(const Duration(days: 5)),
      deadline: DateTime.now().add(const Duration(days: 25)),
      circularImageUrl: 'https://images.unsplash.com/photo-1450133064473-71024230f91b?w=1200&q=80',
      applyUrl: 'http://bpsc.teletalk.com.bd',
      examDate: 'ফেব্রুয়ারি ২০২৫ (প্রিলিমিনারি)',
      admitCardStatus: 'আবেদন চলছে',
      description: '৪৭তম বিসিএস পরীক্ষার মাধ্যমে বিভিন্ন ক্যাডারে সাধারণ ও প্রফেশনাল/টেকনিক্যাল পদে মোট ৩,৪৮৭ জন যোগ্য কর্মকর্তা নিয়োগ দেওয়া হবে। আবেদন টেলিটকের মাধ্যমে সম্পন্ন করতে হবে।',
      requirements: [
        'যেকোনো স্বীকৃত বিশ্ববিদ্যালয় থেকে স্নাতক বা সমমান ডিগ্রি',
        'অ্যাপেয়ার্ড প্রার্থীরাও নির্ধারিত শর্তসাপেক্ষে আবেদন করতে পারবেন',
        'টেলিটক সিমের মাধ্যমে পরীক্ষার ফি ৭০০ টাকা প্রদান করতে হবে (ক্ষুদ্র নৃগোষ্ঠী ও প্রতিবন্ধী প্রার্থীদের জন্য ১০০ টাকা)'
      ],
      isFeatured: true,
      logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Government_Seal_of_Bangladesh.svg/1200px-Government_Seal_of_Bangladesh.svg.png',
    ),
    JobCircular(
      id: 'job-03',
      title: 'সহকারী শিক্ষক নিয়োগ বিজ্ঞপ্তি ২০২৪ (সকল জেলা)',
      organization: 'প্রাথমিক শিক্ষা অধিদপ্তর (DPE)',
      category: 'সরকারি চাকরি',
      postCount: '১৩,৭৪৯ জন',
      salary: 'গ্রেড-১৩ (১১,০০০ - ২৬,৫৯০ টাকা)',
      qualification: 'স্বীকৃত বিশ্ববিদ্যালয় হতে যেকোনো বিষয়ে দ্বিতীয় শ্রেণী বা সমমানের সিজিপিএসহ স্নাতক বা সমমান',
      ageLimit: '২১ থেকে ৩০ বছর (কোটাধারীদের জন্য ৩২ বছর)',
      publishDate: DateTime.now().subtract(const Duration(days: 8)),
      deadline: DateTime.now().add(const Duration(days: 12)),
      circularImageUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=1200&q=80',
      applyUrl: 'http://dpe.teletalk.com.bd',
      examDate: '১০ জানুয়ারি ২০২৫',
      admitCardStatus: 'প্রবেশপত্র ডাউনলোড শুরু হয়েছে',
      admitCardUrl: 'http://dpe.teletalk.com.bd/admitcard',
      description: 'সরকারি প্রাথমিক বিদ্যালয়ে রাজস্ব খাতভুক্ত সহকারী শিক্ষক পদে বিশাল নিয়োগ বিজ্ঞপ্তি প্রকাশিত হয়েছে। নারী ও পুরুষ উভয় প্রার্থীরা তাদের নিজ উপজেলা কোটায় আবেদন করতে পারবেন।',
      requirements: [
        'ন্যূনতম দ্বিতীয় শ্রেণী বা সিজিপিএ ২.২৫ সহ স্নাতক পাস',
        'প্রার্থীর নিজ স্থায়ী ঠিকানার উপজেলায় আবেদন করতে হবে',
        'আবেদন ফি ২২০ টাকা টেলিটকের মাধ্যমে জমা দিতে হবে'
      ],
      isFeatured: true,
      logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Government_Seal_of_Bangladesh.svg/1200px-Government_Seal_of_Bangladesh.svg.png',
    ),
    JobCircular(
      id: 'job-04',
      title: 'সহকারী স্টেশন মাস্টার ও ট্রাফিক শিক্ষানবিস নিয়োগ',
      organization: 'বাংলাদেশ রেলওয়ে (Bangladesh Railway)',
      category: 'সরকারি চাকরি',
      postCount: '৫৬০ জন',
      salary: 'গ্রেড-১৫ (৯,৭০০ - ২৩,৪৯০ টাকা)',
      qualification: 'যেকোনো স্বীকৃত বিশ্ববিদ্যালয় হতে দ্বিতীয় বিভাগ বা সমমানের সিজিপিএসহ স্নাতক ডিগ্রি',
      ageLimit: '১৮ থেকে ৩০ বছর',
      publishDate: DateTime.now().subtract(const Duration(days: 10)),
      deadline: DateTime.now().add(const Duration(days: 7)),
      circularImageUrl: 'https://images.unsplash.com/photo-1474487548417-781cb71495f3?w=1200&q=80',
      applyUrl: 'http://br.teletalk.com.bd',
      examDate: '২৩ ডিসেম্বর ২০২৪',
      admitCardStatus: 'প্রবেশপত্র প্রস্তুত',
      admitCardUrl: 'http://br.teletalk.com.bd',
      description: 'বাংলাদেশ রেলওয়ের পূর্ব ও পশ্চিম জোনে সহকারী স্টেশন মাস্টার পদে সরাসরি নিয়োগের জন্য দরখাস্ত আহ্বান করা হয়েছে। কম্পিউটার চালনায় পারদর্শী প্রার্থীদের অগ্রাধিকার দেওয়া হবে।',
      requirements: [
        'স্নাতক পাস এবং কম্পিউটার পরিচালনায় দক্ষতা থাকতে হবে',
        'শারীরিক ফিটনেস ও মেডিকেল টেস্টে উত্তীর্ণ হতে হবে',
        'টেলিটক আবেদন ফি ১১২ টাকা'
      ],
      isFeatured: false,
      logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Government_Seal_of_Bangladesh.svg/1200px-Government_Seal_of_Bangladesh.svg.png',
    ),
    JobCircular(
      id: 'job-05',
      title: 'সমন্বিত ১০ ব্যাংক ও আর্থিক প্রতিষ্ঠানে সিনিয়র অফিসার নিয়োগ',
      organization: 'ব্যাংকার্স সিলেকশন কমিটি (BSEC)',
      category: 'ব্যাংক জব',
      postCount: '১,৪২২ জন',
      salary: 'জাতীয় বেতন স্কেল ২০১৫ অনুযায়ী ২২,০০০ - ৫৩,০干部 (গ্রেড-৯)',
      qualification: 'যেকোনো বিষয়ে স্নাতকোত্তর অথবা ৪ বছর মেয়াদী স্নাতক',
      ageLimit: '২১ থেকে ৩০ বছর',
      publishDate: DateTime.now().subtract(const Duration(days: 2)),
      deadline: DateTime.now().add(const Duration(days: 20)),
      circularImageUrl: 'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?w=1200&q=80',
      applyUrl: 'https://erecruitment.bb.org.bd',
      examDate: 'জানুয়ারি ২০২৫',
      admitCardStatus: 'আবেদন চলছে',
      resultStatus: 'প্রিলিমিনারি রেজাল্ট প্রকাশিত',
      resultUrl: 'https://erecruitment.bb.org.bd/result',
      description: 'সোনালী, জনতা, অগ্রণী, রূপালী, বিডিবিএল, বাংলাদেশ কৃষি ব্যাংক সহ ১০টি রাষ্ট্রায়ত্ত ব্যাংকে ১,৪২২ জন সিনিয়র অফিসার নিয়োগের বিজ্ঞপ্তি।',
      requirements: [
        'স্নাতকোত্তর বা ৪ বছর মেয়াদী স্নাতক',
        'কমপক্ষে ২টি প্রথম শ্রেণী থাকতে হবে',
        'অনলাইন ভেরিফিকেশন ও ট্র্যাকিং নম্বর সংরক্ষণ করতে হবে'
      ],
      isFeatured: true,
      logoUrl: 'https://upload.wikimedia.org/wikipedia/en/thumb/7/77/Bangladesh_Bank_Logo.svg/1200px-Bangladesh_Bank_Logo.svg.png',
    ),
    JobCircular(
      id: 'job-06',
      title: 'সৈনিক ও সাধারণ ট্রেডম্যান পদে পুরুষ ও মহিলা নিয়োগ',
      organization: 'বাংলাদেশ সেনাবাহিনী (Bangladesh Army)',
      category: 'সরকারি চাকরি',
      postCount: 'বিশাল সংখ্যক',
      salary: 'সরকারি স্কেল ও সশস্ত্র বাহিনীর সুযোগ-সুবিধা অনুযায়ী',
      qualification: 'এসএসসি/সমমান পরীক্ষায় ন্যূনতম জিপিএ ৩.০০',
      ageLimit: '১৭ থেকে ২০ বছর',
      publishDate: DateTime.now().subtract(const Duration(days: 14)),
      deadline: DateTime.now().add(const Duration(days: 4)),
      circularImageUrl: 'https://images.unsplash.com/photo-1541872703-74c5e44368f9?w=1200&q=80',
      applyUrl: 'https://joinbangladesharmy.army.mil.bd',
      examDate: 'জেলা ভিত্তিক তারিখ সার্কুলারে দেখুন',
      admitCardStatus: 'এসএমএস এর মাধ্যমে রোল পাঠানো হচ্ছে',
      description: 'বাংলাদেশ সেনাবাহিনীতে সৈনিক ট্রেডে তরুণ-তরুণীদের যোগদানের সুযোগ। শারীরিক উচ্চতা: পুরুষ ৫ ফুট ৬ ইঞ্চি, মহিলা ৫ ফুট ২ ইঞ্চি।',
      requirements: [
        'এসএসসি পাস (বিজ্ঞান বিভাগ অগ্রাধিকার পাবে)',
        'সাঁতার জানা বাধ্যতামূলক',
        'অবিবাহিত হতে হবে'
      ],
      isFeatured: false,
      logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Government_Seal_of_Bangladesh.svg/1200px-Government_Seal_of_Bangladesh.svg.png',
    ),
  ];

  Future<List<JobCircular>> getAllCirculars() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_circulars);
  }

  Future<List<JobCircular>> getFeaturedCirculars() async {
    return _circulars.where((c) => c.isFeatured && !c.isExpired).toList();
  }

  Future<List<JobCircular>> getCircularsByCategory(String category) async {
    if (category == 'সকল চাকরি') return _circulars;
    return _circulars.where((c) => c.category == category).toList();
  }

  Future<List<JobCircular>> getExamNotices() async {
    return _circulars.where((c) => c.examDate != null || c.admitCardStatus != null || c.resultStatus != null).toList();
  }

  Future<List<JobCircular>> searchCirculars(String query) async {
    final q = query.toLowerCase();
    return _circulars.where((c) {
      return c.title.toLowerCase().contains(q) ||
          c.organization.toLowerCase().contains(q) ||
          c.qualification.toLowerCase().contains(q);
    }).toList();
  }
}
