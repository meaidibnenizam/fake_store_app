# সেটআপ গাইড — Flutter প্রজেক্ট রান করার ধাপ

এই গাইডে ধাপে ধাপে দেখানো হয়েছে কিভাবে তুমি এই প্রজেক্ট তোমার কম্পিউটারে
রান করবে। এখানে কোনো কোড লিখতে হবে না — শুধু ফাইলগুলো কপি-পেস্ট করতে হবে।

---

## ধাপ ১: Flutter ইন্সটল আছে কিনা চেক করো

টার্মিনাল (CMD বা PowerShell) খুলে লেখো:

```
flutter --version
```

যদি কোনো error আসে, তাহলে Flutter ইন্সটল করতে হবে।
- গাইড: https://docs.flutter.dev/get-started/install
- Windows-এর জন্য `flutter_windows_3.x.x-stable.zip` ডাউনলোড করে
  `C:\flutter` ফোল্ডারে extract করো।
- Environment Variable (Path) এ `C:\flutter\bin` যোগ করো।

---

## ধাপ ২: প্রজেক্ট ফোল্ডার তৈরি করো

টার্মিনালে লেখো:

```
flutter create fake_store_app
cd fake_store_app
```

এটা নতুন একটা Flutter প্রজেক্ট তৈরি করবে।

---

## ধাপ ৩: আমার দেওয়া ফাইলগুলো কপি করো

`fake_store_app` ফোল্ডারের ভিতরে `lib` ফোল্ডার আছে। সেখানে নিচের ফাইলগুলো
কপি করো (পুরনো ফাইলগুলো replace করে দাও):

```
lib/
├── main.dart                    ← আমার দেওয়া ফাইল
├── models/
│   └── product.dart             ← আমার দেওয়া ফাইল
├── services/
│   └── product_api.dart         ← আমার দেওয়া ফাইল
├── screens/
│   ├── splash_screen.dart       ← আমার দেওয়া ফাইল
│   ├── home_screen.dart         ← আমার দেওয়া ফাইল
│   └── detail_screen.dart       ← আমার দেওয়া ফাইল
└── widgets/
    └── product_card.dart        ← আমার দেওয়া ফাইল
```

**এবং `pubspec.yaml` ফাইলটাও replace করো** — এতে `http` আর
`cached_network_image` প্যাকেজ যোগ করা আছে।

---

## ধাপ ৪: প্যাকেজ ডাউনলোড করো

টার্মিনালে লেখো:

```
flutter pub get
```

এটা `pubspec.yaml`-এ লেখা প্যাকেজগুলো ডাউনলোড করবে।

---

## ধাপ ৫: এমুলেটর চালু করো বা ফোন কানেক্ট করো

### অপশন A: Android Emulator
- Android Studio খুলো → Device Manager → একটি emulator create করো → চালু করো।

### অপশন B: Physical Phone
- ফোনে Developer Options → USB Debugging চালু করো।
- USB দিয়ে কম্পিউটারে কানেক্ট করো।

চেক করতে টার্মিনালে লেখো:

```
flutter devices
```

---

## ধাপ ৬: অ্যাপ রান করো

টার্মিনালে লেখো:

```
flutter run
```

প্রথমবার রান করতে কয়েক মিনিট লাগতে পারে। তারপর অ্যাপটি তোমার ফোনে বা
emulator-এ খুলে যাবে।

---

## কমন এরর ও সমাধান

| এরর | সমাধান |
|---|---|
| `Target of URI doesn't exist` | `flutter pub get` আবার রান করো। |
| `Waiting for another flutter command` | `flutter clean` → `flutter pub get` |
| Emulator খোলে না | Android Studio → Device Manager → emulator টা আবার চালু করো। |
| `No devices found` | USB debugging চালু আছে কিনা দেখো, বা emulator চালু করো। |
| Internet নেই এরর | এটা expected — error message + "Try Again" বাটন দেখাবে। |

---

## কোড বুঝতে হলে

প্রতিটা ফাইলের ভেতরে প্রচুর comment লেখা আছে। কোন লাইন কী কাজ করে, কেন
লেখা হয়েছে — সব ব্যাখ্যা করা আছে। viva-তে এই comment-গুলোই মূল উত্তর।

**পড়ার ক্রম:**
1. `pubspec.yaml` → কোন প্যাকেজ ব্যবহার হয়েছে
2. `models/product.dart` → JSON থেকে object বানানো হয় কিভাবে
3. `services/product_api.dart` → API call কিভাবে হয়
4. `screens/home_screen.dart` → UI + state management
5. `screens/detail_screen.dart` → navigation
6. `main.dart` → অ্যাপের entry point
