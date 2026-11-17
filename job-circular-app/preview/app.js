/**
 * চাকরির খবর (Job Circular) - Mobile App Simulator Logic
 */

// Dataset
const jobCirculars = [
  {
    id: 'job-01',
    title: 'সহকারী পরিচালক (সাধারণ শাখা) নিয়োগ বিজ্ঞপ্তি ২০২৪',
    organization: 'বাংলাদেশ ব্যাংক (Bangladesh Bank)',
    category: 'ব্যাংক জব',
    postCount: '২২৫ জন',
    salary: '২২,০০০ - ৫৩,০৬০ টাকা (জাতীয় বেতন স্কেল ২০১৫, গ্রেড-৯)',
    qualification: '৪ বছর মেয়াদী স্নাতক বা স্নাতকোত্তর (কমপক্ষে ২টি প্রথম বিভাগ/শ্রেণী)',
    ageLimit: '২১ থেকে ৩০ বছর (মুক্তিযোদ্ধা কোটায় ৩২ বছর)',
    publishDate: '১২ নভেম্বর ২০২৪',
    deadline: new Date(Date.now() + 18 * 86400000),
    deadlineStr: '৩০ নভেম্বর ২০২৪',
    circularImageUrl: 'https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=1200&q=80',
    applyUrl: 'https://erecruitment.bb.org.bd',
    examDate: '১৫ ডিসেম্বর ২০২৪ (সম্ভাব্য)',
    admitCardStatus: 'শীঘ্রই প্রকাশ করা হবে',
    admitCardUrl: 'https://erecruitment.bb.org.bd',
    description: 'বাংলাদেশ ব্যাংকের সহকারী পরিচালক (জেনারেল) পদে ২২৫ জন নিয়োগের জন্য বাংলাদেশি নাগরিকদের কাছ থেকে দরখাস্ত আহ্বান করা হচ্ছে। নির্বাচিত প্রার্থীরা সরকারের গ্রেড-৯ স্কেলে বেতন-ভাতা পাবেন।',
    requirements: [
      'স্বীকৃত বিশ্ববিদ্যালয় হতে যেকোনো বিষয়ে ৪ বছর মেয়াদী স্নাতক/স্নাতকোত্তর',
      'এসএসসি ও তদূর্ধ্ব পর্যায়ে কমপক্ষে ২টিতে ১ম বিভাগ বা সমমানের সিজিপিএ',
      'তৃতীয় বিভাগ/শ্রেণী গ্রহণযোগ্য নয়',
      'অনলাইনে আবেদন ফি ২০০ টাকা বাংলাদেশ ব্যাংকের রিক্রুটমেন্ট পোর্টালের মাধ্যমে প্রদান করতে হবে'
    ]
  },
  {
    id: 'job-02',
    title: '৪৭তম বিসিএস পরীক্ষা ২০২৪ এর বিজ্ঞপ্তি (ক্যাডার ও নন-ক্যাডার)',
    organization: 'বাংলাদেশ সরকারি কর্ম কমিশন (BPSC)',
    category: 'সরকারি চাকরি',
    postCount: '৩,৪৮৭ জন',
    salary: 'গ্রেড-৯ (২২,০০০ - ৫৩,০৬০ টাকা)',
    qualification: 'স্বীকৃত বিশ্ববিদ্যালয় হতে ৪ বছর মেয়াদী স্নাতক (সম্মান) বা সমমানের ডিগ্রি',
    ageLimit: '২১ থেকে ৩২ বছর',
    publishDate: '০৫ নভেম্বর ২০২৪',
    deadline: new Date(Date.now() + 25 * 86400000),
    deadlineStr: '১০ ডিসেম্বর ২০২৪',
    circularImageUrl: 'https://images.unsplash.com/photo-1450133064473-71024230f91b?w=1200&q=80',
    applyUrl: 'http://bpsc.teletalk.com.bd',
    examDate: 'ফেব্রুয়ারি ২০২৫ (প্রিলিমিনারি)',
    admitCardStatus: 'আবেদন চলমান',
    admitCardUrl: 'http://bpsc.teletalk.com.bd',
    description: '৪৭তম বিসিএস পরীক্ষার মাধ্যমে বিভিন্ন ক্যাডারে সাধারণ ও প্রফেশনাল/টেকনিক্যাল পদে মোট ৩,৪৮৭ জন যোগ্য কর্মকর্তা নিয়োগ দেওয়া হবে। আবেদন টেলিটকের মাধ্যমে সম্পন্ন করতে হবে।',
    requirements: [
      'যেকোনো স্বীকৃত বিশ্ববিদ্যালয় থেকে স্নাতক বা সমমান ডিগ্রি',
      'অ্যাপেয়ার্ড প্রার্থীরাও নির্ধারিত শর্তসাপেক্ষে আবেদন করতে পারবেন',
      'টেলিটক সিমের মাধ্যমে পরীক্ষার ফি ৭০০ টাকা প্রদান করতে হবে'
    ]
  },
  {
    id: 'job-03',
    title: 'সহকারী শিক্ষক নিয়োগ বিজ্ঞপ্তি ২০২৪ (সকল জেলা)',
    organization: 'প্রাথমিক শিক্ষা অধিদপ্তর (DPE)',
    category: 'প্রাইমারি শিক্ষক',
    postCount: '১৩,৭৪৯ জন',
    salary: 'গ্রেড-১৩ (১১,০০০ - ২৬,৫৯০ টাকা)',
    qualification: 'দ্বিতীয় শ্রেণী বা সমমানের সিজিপিএসহ স্নাতক বা সমমান',
    ageLimit: '২১ থেকে ৩০ বছর (কোটাধারীদের জন্য ৩২ বছর)',
    publishDate: '২৮ অক্টোবর ২০২৪',
    deadline: new Date(Date.now() + 3 * 86400000), // Urgent!
    deadlineStr: '২০ নভেম্বর ২০২৪',
    circularImageUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=1200&q=80',
    applyUrl: 'http://dpe.teletalk.com.bd',
    examDate: '১০ জানুয়ারি ২০২৫',
    admitCardStatus: 'প্রবেশপত্র প্রস্তুত - ডাউনলোড করুন',
    admitCardUrl: 'http://dpe.teletalk.com.bd',
    description: 'সরকারি প্রাথমিক বিদ্যালয়ে রাজস্ব খাতভুক্ত সহকারী শিক্ষক পদে বিশাল নিয়োগ বিজ্ঞপ্তি প্রকাশিত হয়েছে। নারী ও পুরুষ উভয় প্রার্থীরা তাদের নিজ উপজেলা কোটায় আবেদন করতে পারবেন।',
    requirements: [
      'ন্যূনতম দ্বিতীয় শ্রেণী বা সিজিপিএ ২.২৫ সহ স্নাতক পাস',
      'প্রার্থীর নিজ স্থায়ী ঠিকানার উপজেলায় আবেদন করতে হবে',
      'আবেদন ফি ২২০ টাকা টেলিটকের মাধ্যমে জমা দিতে হবে'
    ]
  },
  {
    id: 'job-04',
    title: 'সহকারী স্টেশন মাস্টার ও ট্রাফিক শিক্ষানবিস নিয়োগ',
    organization: 'বাংলাদেশ রেলওয়ে (Bangladesh Railway)',
    category: 'রেলওয়ে',
    postCount: '৫৬০ জন',
    salary: 'গ্রেড-১৫ (৯,৭০০ - ২৩,৪৯০ টাকা)',
    qualification: 'যেকোনো বিষয়ে দ্বিতীয় বিভাগ বা সমমানের সিজিপিএসহ স্নাতক ডিগ্রি',
    ageLimit: '১৮ থেকে ৩০ বছর',
    publishDate: '০১ নভেম্বর ২০২৪',
    deadline: new Date(Date.now() + 7 * 86400000),
    deadlineStr: '২৪ নভেম্বর ২০২৪',
    circularImageUrl: 'https://images.unsplash.com/photo-1474487548417-781cb71495f3?w=1200&q=80',
    applyUrl: 'http://br.teletalk.com.bd',
    examDate: '২৩ ডিসেম্বর ২০২৪',
    admitCardStatus: 'প্রবেশপত্র ডাউনলোড শুরু হয়েছে',
    admitCardUrl: 'http://br.teletalk.com.bd',
    description: 'বাংলাদেশ রেলওয়ের পূর্ব ও পশ্চিম জোনে সহকারী স্টেশন মাস্টার পদে সরাসরি নিয়োগের জন্য দরখাস্ত আহ্বান করা হয়েছে। কম্পিউটার চালনায় পারদর্শী প্রার্থীদের অগ্রাধিকার দেওয়া হবে।',
    requirements: [
      'স্নাতক পাস এবং কম্পিউটার পরিচালনায় দক্ষতা থাকতে হবে',
      'শারীরিক ফিটনেস ও মেডিকেল টেস্টে উত্তীর্ণ হতে হবে',
      'টেলিটক আবেদন ফি ১১২ টাকা'
    ]
  },
  {
    id: 'job-05',
    title: 'সমন্বিত ১০ ব্যাংক ও আর্থিক প্রতিষ্ঠানে সিনিয়র অফিসার নিয়োগ',
    organization: 'ব্যাংকার্স সিলেকশন কমিটি (BSEC)',
    category: 'ব্যাংক জব',
    postCount: '১,৪২২ জন',
    salary: 'জাতীয় বেতন স্কেল ২০১৫ অনুযায়ী ২২,০০০ - ৫৩,০৬০ টাকা (গ্রেড-৯)',
    qualification: 'যেকোনো বিষয়ে স্নাতকোত্তর অথবা ৪ বছর মেয়াদী স্নাতক',
    ageLimit: '২১ থেকে ৩০ বছর',
    publishDate: '০৮ নভেম্বর ২০২৪',
    deadline: new Date(Date.now() + 20 * 86400000),
    deadlineStr: '০৫ ডিসেম্বর ২০২৪',
    circularImageUrl: 'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?w=1200&q=80',
    applyUrl: 'https://erecruitment.bb.org.bd',
    examDate: 'জানুয়ারি ২০২৫',
    admitCardStatus: 'আবেদন চলছে',
    resultStatus: 'প্রিলিমিনারি রেজাল্ট প্রকাশিত',
    resultUrl: 'https://erecruitment.bb.org.bd',
    description: 'সোনালী, জনতা, অগ্রণী, রূপালী, বিডিবিএল, বাংলাদেশ কৃষি ব্যাংক সহ ১০টি রাষ্ট্রায়ত্ত ব্যাংকে ১,৪২২ জন সিনিয়র অফিসার নিয়োগের বিজ্ঞপ্তি।',
    requirements: [
      'স্নাতকোত্তর বা ৪ বছর মেয়াদী স্নাতক',
      'কমপক্ষে ২টি প্রথম শ্রেণী থাকতে হবে',
      'অনলাইন ভেরিফিকেশন ও ট্র্যাকিং নম্বর সংরক্ষণ করতে হবে'
    ]
  },
  {
    id: 'job-06',
    title: 'সৈনিক ও সাধারণ ট্রেডম্যান পদে পুরুষ ও মহিলা নিয়োগ',
    organization: 'বাংলাদেশ সেনাবাহিনী (Bangladesh Army)',
    category: 'ডিফেন্স',
    postCount: 'বিশাল সংখ্যক',
    salary: 'সরকারি স্কেল ও সশস্ত্র বাহিনীর সুযোগ-সুবিধা অনুযায়ী',
    qualification: 'এসএসসি/সমমান পরীক্ষায় ন্যূনতম জিপিএ ৩.০০',
    ageLimit: '১৭ থেকে ২০ বছর',
    publishDate: '১৫ অক্টোবর ২০২৪',
    deadline: new Date(Date.now() + 2 * 86400000), // Urgent!
    deadlineStr: '১৮ নভেম্বর ২০২৪',
    circularImageUrl: 'https://images.unsplash.com/photo-1541872703-74c5e44368f9?w=1200&q=80',
    applyUrl: 'https://joinbangladesharmy.army.mil.bd',
    examDate: 'জেলা ভিত্তিক তারিখ সার্কুলারে দেখুন',
    admitCardStatus: 'এসএমএস এর মাধ্যমে পাঠানো হচ্ছে',
    description: 'বাংলাদেশ সেনাবাহিনীতে সৈনিক ট্রেডে তরুণ-তরুণীদের যোগদানের সুযোগ। শারীরিক উচ্চতা: পুরুষ ৫ ফুট ৬ ইঞ্চি, মহিলা ৫ ফুট ২ ইঞ্চি।',
    requirements: [
      'এসএসসি পাস (বিজ্ঞান বিভাগ অগ্রাধিকার পাবে)',
      'সাঁতার জানা বাধ্যতামূলক',
      'অবিবাহিত হতে হবে'
    ]
  }
];

// App State
const state = {
  activeTab: 0,
  activeCategory: 'সকল চাকরি',
  searchQuery: '',
  bookmarkedIds: JSON.parse(localStorage.getItem('job_bookmarks') || '["job-01", "job-03"]'),
  currentJob: null
};

// DOM Refs
const dom = {
  jobsContainer: document.getElementById('jobsContainer'),
  examsContainer: document.getElementById('examsContainer'),
  bookmarksContainer: document.getElementById('bookmarksContainer'),
  jobCountText: document.getElementById('jobCountText'),
  searchInput: document.getElementById('searchInput'),
  clearSearchBtn: document.getElementById('clearSearchBtn'),
  topSearchRow: document.getElementById('topSearchRow'),
  categoryChipsBar: document.getElementById('categoryChipsBar'),
  appHeaderTitle: document.getElementById('appHeaderTitle'),
  
  // Modal
  detailsModal: document.getElementById('detailsModal'),
  detailCategoryBadge: document.getElementById('detailCategoryBadge'),
  detailTitle: document.getElementById('detailTitle'),
  detailOrg: document.getElementById('detailOrg'),
  detailDeadlineText: document.getElementById('detailDeadlineText'),
  detailRemainingText: document.getElementById('detailRemainingText'),
  detailPostCount: document.getElementById('detailPostCount'),
  detailSalary: document.getElementById('detailSalary'),
  detailQualification: document.getElementById('detailQualification'),
  detailAge: document.getElementById('detailAge'),
  detailPublishDate: document.getElementById('detailPublishDate'),
  detailDescription: document.getElementById('detailDescription'),
  detailRequirements: document.getElementById('detailRequirements'),
  detailCircularImg: document.getElementById('detailCircularImg'),
  modalBookmarkBtn: document.getElementById('modalBookmarkBtn'),
  
  // Zoom Modal
  zoomModal: document.getElementById('zoomModal'),
  zoomModalImg: document.getElementById('zoomModalImg'),
  toast: document.getElementById('toast')
};

// Initialize
window.addEventListener('DOMContentLoaded', () => {
  renderJobs();
  renderExams();
  renderBookmarks();
});

// ==========================================================================
// Rendering Job Cards
// ==========================================================================

function renderJobs() {
  let list = jobCirculars;

  // Category filter
  if (state.activeCategory !== 'সকল চাকরি') {
    list = list.filter(j => j.category === state.activeCategory);
  }

  // Search filter
  if (state.searchQuery) {
    const q = state.searchQuery.toLowerCase();
    list = list.filter(j =>
      j.title.toLowerCase().includes(q) ||
      j.organization.toLowerCase().includes(q) ||
      j.qualification.toLowerCase().includes(q)
    );
  }

  dom.jobCountText.textContent = `মোট ${list.length}টি সার্কুলার পাওয়া গেছে`;

  if (list.length === 0) {
    dom.jobsContainer.innerHTML = `
      <div style="text-align:center; padding: 40px 10px; color:#64748b;">
        <div style="font-size:2.5rem; margin-bottom:8px;">🔍</div>
        <div style="font-weight:700;">কোনো সার্কুলার পাওয়া যায়নি</div>
        <div style="font-size:0.8rem; margin-top:4px;">অন্য কোনো শব্দ দিয়ে খুঁজে দেখুন</div>
      </div>
    `;
    return;
  }

  let html = '';
  list.forEach(job => {
    const isBookmarked = state.bookmarkedIds.includes(job.id);
    const daysRemaining = Math.max(0, Math.ceil((job.deadline - new Date()) / 86400000));
    const isUrgent = daysRemaining <= 3;
    const remainingText = daysRemaining === 0 ? 'আজই শেষ দিন!' : `${daysRemaining} দিন বাকি`;

    html += `
      <div class="job-card ${isUrgent ? 'urgent' : ''}" onclick="openJobDetails('${job.id}')">
        <div class="jc-header">
          <div class="jc-avatar">
            ${job.category === 'ব্যাংক জব' ? '🏦' : job.category === 'রেলওয়ে' ? '🚆' : job.category === 'ডিফেন্স' ? '🛡️' : '🏛️'}
          </div>
          <div class="jc-meta">
            <div class="jc-org">${escapeHtml(job.organization)}</div>
            <div class="jc-title">${escapeHtml(job.title)}</div>
          </div>
          <button class="jc-bookmark-btn ${isBookmarked ? 'bookmarked' : ''}" onclick="event.stopPropagation(); toggleBookmark('${job.id}')">
            ${isBookmarked ? '⭐' : '☆'}
          </button>
        </div>

        <div class="jc-specs">
          <div class="jc-spec-row">
            <span>🎓</span>
            <span style="overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${escapeHtml(job.qualification)}</span>
          </div>
          <div class="jc-spec-row">
            <span>👥</span>
            <span>পদসংখ্যা: <b>${escapeHtml(job.postCount)}</b></span>
          </div>
        </div>

        <div class="jc-footer">
          <span class="jc-category-tag">${escapeHtml(job.category)}</span>
          <span class="jc-deadline-tag ${isUrgent ? 'urgent' : ''}">
            <span>⏰</span>
            <span>${remainingText}</span>
          </span>
        </div>
      </div>
    `;
  });

  dom.jobsContainer.innerHTML = html;
}

// ==========================================================================
// Exam Notices & Bookmarks Render
// ==========================================================================

function renderExams() {
  let html = '';
  jobCirculars.forEach(job => {
    if (!job.examDate && !job.admitCardStatus) return;

    html += `
      <div class="exam-card">
        <div class="exam-card-title">${escapeHtml(job.title)}</div>
        <div class="exam-card-org">${escapeHtml(job.organization)}</div>
        <div class="exam-notice-row">
          <span>📅</span>
          <span><b>পরীক্ষার তারিখ:</b> ${job.examDate || 'তারিখ শীঘ্রই ঘোষণা করা হবে'}</span>
        </div>
        ${job.admitCardStatus ? `
          <div class="exam-notice-row" style="background:#fef3c7; color:#92400e;">
            <span>🎫</span>
            <span><b>প্রবেশপত্র:</b> ${job.admitCardStatus}</span>
          </div>
        ` : ''}
        <div class="exam-btn-row">
          <button class="btn-admit" style="background:#64748b;" onclick="openJobDetails('${job.id}')">সার্কুলার দেখুন</button>
          ${job.admitCardUrl ? `
            <button class="btn-admit" onclick="window.open('${job.admitCardUrl}', '_blank')">অ্যাডমিট কার্ড</button>
          ` : ''}
        </div>
      </div>
    `;
  });
  dom.examsContainer.innerHTML = html;
}

function renderBookmarks() {
  const list = jobCirculars.filter(j => state.bookmarkedIds.includes(j.id));
  if (list.length === 0) {
    dom.bookmarksContainer.innerHTML = `
      <div style="text-align:center; padding: 50px 20px; color:#64748b;">
        <div style="font-size:3rem; margin-bottom:10px;">⭐</div>
        <div style="font-weight:700; font-size:1rem;">কোনো সংরক্ষিত সার্কুলার নেই</div>
        <div style="font-size:0.85rem; margin-top:6px;">যেসব সার্কুলার পরে দেখতে চান সেগুলোতে ⭐ চিহ্নে ক্লিক করে সেভ করুন।</div>
      </div>
    `;
    return;
  }

  let html = '';
  list.forEach(job => {
    const daysRemaining = Math.max(0, Math.ceil((job.deadline - new Date()) / 86400000));
    html += `
      <div class="job-card" onclick="openJobDetails('${job.id}')">
        <div class="jc-header">
          <div class="jc-avatar">💼</div>
          <div class="jc-meta">
            <div class="jc-org">${escapeHtml(job.organization)}</div>
            <div class="jc-title">${escapeHtml(job.title)}</div>
          </div>
          <button class="jc-bookmark-btn bookmarked" onclick="event.stopPropagation(); toggleBookmark('${job.id}')">
            ⭐
          </button>
        </div>
        <div class="jc-footer">
          <span class="jc-category-tag">${escapeHtml(job.category)}</span>
          <span class="jc-deadline-tag">⏰ ${daysRemaining} দিন বাকি</span>
        </div>
      </div>
    `;
  });
  dom.bookmarksContainer.innerHTML = html;
}

// ==========================================================================
// Category & Search Handlers
// ==========================================================================

function setCategory(cat, element) {
  state.activeCategory = cat;
  document.querySelectorAll('.chips-scroll .chip').forEach(c => c.classList.remove('active'));
  if (element) element.classList.add('active');
  renderJobs();
}

function handleSearch() {
  state.searchQuery = dom.searchInput.value.trim();
  dom.clearSearchBtn.style.display = state.searchQuery ? 'block' : 'none';
  renderJobs();
}

function clearSearch() {
  dom.searchInput.value = '';
  state.searchQuery = '';
  dom.clearSearchBtn.style.display = 'none';
  renderJobs();
}

// ==========================================================================
// Tab Switching
// ==========================================================================

function switchTab(tabIndex, element) {
  state.activeTab = tabIndex;
  document.querySelectorAll('.bottom-nav .nav-tab').forEach(b => b.classList.remove('active'));
  if (element) element.classList.add('active');

  const views = ['viewHome', 'viewExams', 'viewBookmarks'];
  views.forEach((vId, idx) => {
    const el = document.getElementById(vId);
    el.style.display = idx === tabIndex ? 'block' : 'none';
  });

  if (tabIndex === 0) {
    dom.topSearchRow.style.display = 'block';
    dom.categoryChipsBar.style.display = 'flex';
    dom.appHeaderTitle.textContent = 'চাকরির খবর';
  } else if (tabIndex === 1) {
    dom.topSearchRow.style.display = 'none';
    dom.categoryChipsBar.style.display = 'none';
    dom.appHeaderTitle.textContent = 'পরীক্ষার নোটিশ';
    renderExams();
  } else if (tabIndex === 2) {
    dom.topSearchRow.style.display = 'none';
    dom.categoryChipsBar.style.display = 'none';
    dom.appHeaderTitle.textContent = 'সংরক্ষিত সার্কুলার';
    renderBookmarks();
  }
}

// ==========================================================================
// Job Details Modal
// ==========================================================================

function openJobDetails(id) {
  const job = jobCirculars.find(j => j.id === id);
  if (!job) return;

  state.currentJob = job;
  const daysRemaining = Math.max(0, Math.ceil((job.deadline - new Date()) / 86400000));
  const isUrgent = daysRemaining <= 3;

  dom.detailCategoryBadge.textContent = job.category;
  dom.detailTitle.textContent = job.title;
  dom.detailOrg.textContent = job.organization;
  dom.detailDeadlineText.textContent = `আবেদনের শেষ তারিখ: ${job.deadlineStr}`;
  dom.detailRemainingText.textContent = daysRemaining === 0 ? 'আজই শেষ দিন!' : `${daysRemaining} দিন বাকি`;
  dom.detailPostCount.textContent = job.postCount;
  dom.detailSalary.textContent = job.salary;
  dom.detailQualification.textContent = job.qualification;
  dom.detailAge.textContent = job.ageLimit;
  dom.detailPublishDate.textContent = job.publishDate;
  dom.detailDescription.textContent = job.description;

  // Requirements List
  let reqHtml = '';
  job.requirements.forEach(r => {
    reqHtml += `<li>${escapeHtml(r)}</li>`;
  });
  dom.detailRequirements.innerHTML = reqHtml;

  // Circular Image
  dom.detailCircularImg.src = job.circularImageUrl;

  // Bookmark icon in modal
  updateModalBookmarkBtn();

  dom.detailsModal.style.display = 'flex';
}

function closeDetailsModal() {
  dom.detailsModal.style.display = 'none';
  state.currentJob = null;
}

function updateModalBookmarkBtn() {
  if (state.currentJob) {
    const isBookmarked = state.bookmarkedIds.includes(state.currentJob.id);
    dom.modalBookmarkBtn.textContent = isBookmarked ? '⭐' : '☆';
  }
}

function toggleModalBookmark() {
  if (state.currentJob) {
    toggleBookmark(state.currentJob.id);
    updateModalBookmarkBtn();
  }
}

function toggleBookmark(id) {
  if (state.bookmarkedIds.includes(id)) {
    state.bookmarkedIds = state.bookmarkedIds.filter(x => x !== id);
    showToast('বুকমার্ক থেকে মুছে ফেলা হয়েছে');
  } else {
    state.bookmarkedIds.push(id);
    showToast('⭐ বুকমার্কে সংরক্ষণ করা হয়েছে');
  }
  localStorage.setItem('job_bookmarks', JSON.stringify(state.bookmarkedIds));
  renderJobs();
  renderBookmarks();
}

function openApplyUrl() {
  if (state.currentJob && state.currentJob.applyUrl) {
    window.open(state.currentJob.applyUrl, '_blank');
  }
}

function shareCurrentJob() {
  if (!state.currentJob) return;
  const text = `📌 ${state.currentJob.title}\n🏢 প্রতিষ্ঠান: ${state.currentJob.organization}\n👥 পদসংখ্যা: ${state.currentJob.postCount}\n⏰ শেষ তারিখ: ${state.currentJob.deadlineStr}\n🔗 আবেদন লিংক: ${state.currentJob.applyUrl}`;
  if (navigator.clipboard) {
    navigator.clipboard.writeText(text).then(() => showToast('সার্কুলার কপি করা হয়েছে!'));
  } else {
    prompt('Copy job circular:', text);
  }
}

function openShareApp() {
  showToast('চাকরির খবর অ্যাপটি শেয়ার করার লিংক কপি করা হয়েছে!');
}

// ==========================================================================
// Zoom Circular Image
// ==========================================================================

function openCircularZoom() {
  if (state.currentJob) {
    dom.zoomModalImg.src = state.currentJob.circularImageUrl;
    dom.zoomModal.style.display = 'flex';
  }
}

function closeCircularZoom() {
  dom.zoomModal.style.display = 'none';
}

// ==========================================================================
// Utilities
// ==========================================================================

function toggleDeviceFrame() {
  const shell = document.getElementById('phoneShell');
  shell.classList.toggle('frameless');
}

function showToast(msg) {
  dom.toast.textContent = msg;
  dom.toast.classList.add('show');
  setTimeout(() => dom.toast.classList.remove('show'), 3000);
}

function escapeHtml(text) {
  if (!text) return '';
  return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

// Service Worker Registration for Phone Installation
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('sw.js').catch(() => {});
  });
}

