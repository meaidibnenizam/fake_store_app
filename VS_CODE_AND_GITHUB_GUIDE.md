# VS Code-এ প্রজেক্ট রান করা + GitHub-এ Push করা
### সম্পূর্ণ নতুনদের জন্য, একদম শুরু থেকে

---

# ভাগ ১: একবারের সেটআপ (শুধু প্রথমবার করতে হবে)

এই ভাগটা একবার করলে আর কখনো করতে হবে না।

## ১.১ Flutter ইন্সটল করো

1. এই লিঙ্কে যাও: **https://docs.flutter.dev/get-started/install/windows**
2. **"Download Flutter SDK"** বাটনে ক্লিক করো (একটা `.zip` ফাইল নামবে)
3. zip ফাইলটা extract করো **`C:\flutter`** তে

> ⚠️ **গুরুত্বপূর্ণ:** `C:\Program Files` বা `Desktop`-এ extract করো না।
> জায়গার নামে space বা বিশেষ চিহ্ন থাকলে Flutter কাজ করে না।
> শুধু `C:\flutter` ব্যবহার করো।

extract করার পর ভেতরে এমন থাকবে: `C:\flutter\bin\flutter.bat`

## ১.২ Flutter কে PATH-এ যোগ করো

এটা না করলে টার্মিনালে `flutter` কমান্ড কাজ করবে না।

1. Windows সার্চে লেখো: **"environment variables"**
2. **"Edit the system environment variables"** এ ক্লিক করো
3. নিচে **"Environment Variables..."** বাটনে ক্লিক করো
4. উপরের বক্সে **`Path`** সিলেক্ট করে **Edit** ক্লিক করো
5. **New** ক্লিক করে লেখো: `C:\flutter\bin`
6. **OK → OK → OK** দিয়ে সব বন্ধ করো
7. **টার্মিনাল (CMD) বন্ধ করে আবার খোলো** (এটা জরুরি, না হলে PATH কাজ করবে না)

এখন চেক করো — টার্মিনালে লেখো:

```
flutter --version
```

কিছু লেখা আসলে Flutter ঠিকমতো ইন্সটল হয়েছে ✅

## ১.৩ Android Studio ইন্সটল করো

অ্যাপ চালানোর জন্য একটা ফোন/emulator দরকার। Android Studio ইন্সটল করলে
সাথে Android SDK আর emulator দুটোই পেয়ে যাবে।

1. ডাউনলোড: **https://developer.android.com/studio**
2. ইন্সটল করার সময় সব default অপশন ঠিক রেখে Next দিতে থাকো
3. ইন্সটল শেষে Android Studio খুলে **"More Actions" → "SDK Manager"** এ যাও
4. **SDK Platforms** ট্যাবে **Android 14 (API 34)** বা যেকোনো একটা সিলেক্ট করে Apply করো
5. **SDK Tools** ট্যাবে **"Android SDK Command-line Tools"** এ টিক দিয়ে Apply করো

## ১.৪ Flutter এর সাথে Android কানেক্ট করো

টার্মিনালে লেখো:

```
flutter doctor
```

সবুজ টিক ✅ থাকলে সব ঠিক। হলুদ `!` বা লাল `✗` থাকলে নিচের কমান্ডগুলো চালাও:

```
flutter doctor --android-licenses
```

এটা লাইসেন্সের জন্য বারবার `y` লিখে Enter দাও।

তারপর আবার:

```
flutter doctor
```

## ১.৫ VS Code ইন্সটল করো

1. ডাউনলোড: **https://code.visualstudio.com**
2. ইন্সটল করে খোলো
3. বাম দিকের **Extensions** আইকনে ক্লিক করো (চারটা বর্গাকার বক্সের মতো দেখতে)
4. সার্চে লেখো **"Flutter"** → **Google** এর তৈরি **Flutter** extension টা Install করো
   (এটা নিজে থেকেই **Dart** extension-ও ইন্সটল করে দেবে)

## ১.৬ Git ইন্সটল করো

GitHub-এ push করতে Git লাগবে।

1. ডাউনলোড: **https://git-scm.com/download/win**
2. ইন্সটল করার সময় সব default রেখে Next দিতে থাকো
3. ইন্সটল শেষে টার্মিনাল বন্ধ করে আবার খুলে চেক করো:

```
git --version
```

## ১.৭ Git কে তোমার নাম বলো

এটা একবার করতে হয়। টার্মিনালে লেখো (নিজের নাম আর ইমেইল দাও):

```
git config --global user.name "Tomar Naam"
git config --global user.email "tomar.email@example.com"
```

> এখানে যে ইমেইল দেবে, GitHub অ্যাকাউন্টের ইমেইলের সাথে মিলিয়ে দিও।

---

# ভাগ ২: প্রজেক্ট তৈরি করা

## ২.১ একটা ফোল্ডার বানাও

ধরো তুমি সব প্রজেক্ট `C:\projects` ফোল্ডারে রাখবে। টার্মিনালে লেখো:

```
cd C:\
mkdir projects
cd projects
```

## ২.২ Flutter প্রজেক্ট তৈরি করো

```
flutter create fake_store_app
```

কিছুক্ষণ সময় নেবে। শেষ হলে একটা `fake_store_app` ফোল্ডার তৈরি হবে।

## ২.৩ VS Code-এ ফোল্ডারটা খোলো

টার্মিনালে লেখো:

```
code fake_store_app
```

অথবা VS Code খুলে **File → Open Folder** দিয়ে `C:\projects\fake_store_app` সিলেক্ট করো।

> ⚠️ **খুব গুরুত্বপূর্ণ:** `fake_store_app` ফোল্ডারটা খুলতে হবে, তার ভেতরের
> `lib` ফোল্ডার না। বাম দিকে ফাইল লিস্টে `lib`, `pubspec.yaml`, `android`,
> `ios` — এগুলো দেখা যাওয়ার কথা।

---

# ভাগ ৩: আমার দেওয়া কোড বসানো

## ৩.১ পুরনো ফাইলগুলো মুছে ফেলো

VS Code-এর বাম দিকের ফাইল লিস্টে `lib` ফোল্ডার খোলো। ভেতরে `main.dart`
আছে। এটার উপর right-click করে **Delete** দাও।

## ৩.২ নতুন ফোল্ডার বানাও

`lib` ফোল্ডারের উপর right-click → **New Folder** → নাম দাও `models`

এভাবে আরও তিনটা ফোল্ডার বানাও: `services`, `screens`, `widgets`

শেষে `lib`-এর ভেতরে এমন থাকবে:

```
lib/
├── models/
├── services/
├── screens/
└── widgets/
```

## ৩.৩ ফাইলগুলো তৈরি করো

প্রতিটা ফোল্ডারের উপর right-click → **New File** → নাম দাও → তারপর আমার
দেওয়া কোডটা পুরোটা কপি করে পেস্ট করো → **Ctrl + S** দিয়ে save করো।

| ফোল্ডার | ফাইলের নাম | কোন ফাইলের কোড |
|---|---|---|
| `lib/` | `main.dart` | `main.dart` |
| `lib/models/` | `product.dart` | `product.dart` |
| `lib/services/` | `product_api.dart` | `product_api.dart` |
| `lib/screens/` | `splash_screen.dart` | `splash_screen.dart` |
| `lib/screens/` | `home_screen.dart` | `home_screen.dart` |
| `lib/screens/` | `detail_screen.dart` | `detail_screen.dart` |
| `lib/widgets/` | `product_card.dart` | `product_card.dart` |

## ৩.৪ pubspec.yaml replace করো

বাম দিকের লিস্টে `pubspec.yaml` ফাইলটা আছে। ওটার উপর ক্লিক করে **পুরো
কনটেন্ট মুছে** (Ctrl+A তারপর Delete) আমার দেওয়া `pubspec.yaml`-এর কোড
পেস্ট করো। **Ctrl + S** দিয়ে save করো।

> ⚠️ **সাবধান:** `pubspec.yaml`-এ space আর indentation খুব গুরুত্বপূর্ণ।
> পেস্ট করার পর দেখো কোনো লাইন আগের চেয়ে বেশি/কম দাঁতে ঢুকে গেছে কিনা।
> পেস্ট করার সময় নিচের দিকের `flutter:` ব্লকটা ঠিকঠাক আছে কিনা দেখো।

## ৩.৫ প্যাকেজ ডাউনলোড করো

VS Code-এর ভেতরে টার্মিনাল খোলো: উপরের মেনু **Terminal → New Terminal**
(অথবা `Ctrl + ~` চাপো)

নিচে যে টার্মিনাল খুলবে সেখানে লেখো:

```
flutter pub get
```

কিছুক্ষণ পর `Got dependencies!` লেখা আসলে সব ঠিক ✅

---

# ভাগ ৪: অ্যাপ রান করা

## ৪.১ একটা ডিভাইস চালু করো

**অপশন A — Emulator (কম্পিউটারে):**

1. Android Studio খোলো
2. **Device Manager** এ যাও
3. একটা emulator না থাকলে **Create Device** দিয়ে একটা বানাও
   (Pixel 6 / API 34 দিলেই হবে)
4. ▶️ প্লে বাটনে ক্লিক করে চালু করো

**অপশন B — আসল ফোন:**

1. ফোনে **Settings → About Phone** এ যাও
2. **Build Number** এ ৭ বার ট্যাপ করো (এতে Developer Options চালু হবে)
3. **Settings → Developer Options** এ গিয়ে **USB Debugging** চালু করো
4. USB দিয়ে কম্পিউটারে কানেক্ট করো
5. ফোনে "Allow USB debugging?" এলে **Allow** দাও

চেক করো ডিভাইস ধরা পড়েছে কিনা:

```
flutter devices
```

তোমার emulator বা ফোনের নাম দেখালে ঠিক আছে।

## ৪.২ অ্যাপ চালাও

VS Code-এর নিচের ডান কোণে একটা ডিভাইসের নাম দেখাবে (যেমন `sdk gphone64 x86 64`)।
ওখানে ক্লিক করে তোমার ডিভাইস সিলেক্ট করো।

তারপর তিনটে উপায়ের যেকোনো একটা:

- **`F5` চাপো** (সবচেয়ে সহজ)
- অথবা টার্মিনালে: `flutter run`
- অথবা `main.dart` খুলে উপরে **Run** বাটনে ক্লিক করো

প্রথমবার রান হতে ২-৫ মিনিট লাগতে পারে — ধৈর্য ধরো। তারপর তোমার ফোনে
অ্যাপটা খুলে যাবে 🎉

## ৪.৩ কোড বদলালে কী করবে

এটা Flutter-এর সবচেয়ে মজার অংশ — **Hot Reload**।

কোনো টেক্সট বা রঙ বদলে **Ctrl + S** চাপো। সাথে সাথে ফোনে পরিবর্তন দেখা যাবে।
অ্যাপ আবার রান করতে হবে না।

> কিছু কিছু পরিবর্তনে (যেমন নতুন ফোল্ডার যোগ করলে) পুরো রিস্টার্ট লাগে।
> তখন টার্মিনালে `R` (বড় হাতের) চাপো, অথবা আবার F5 দাও।

## ৪.৪ সমস্যা হলে

| সমস্যা | সমাধান |
|---|---|
| `flutter: command not found` | PATH ঠিক হয়নি। টার্মিনাল বন্ধ করে আবার খোলো। |
| `No devices found` | Emulator চালু করো বা USB debugging চেক করো। |
| `Waiting for another flutter command` | `flutter clean` তারপর `flutter pub get` |
| লাল দাগ (error) দেখাচ্ছে | `flutter pub get` চালাও, তারপর VS Code রিস্টার্ট করো। |
| `Gradle` সংক্রান্ত error | ইন্টারনেট চেক করো, প্রথমবার Gradle ডাউনলোড হয়। |
| অ্যাপে "Could not load products" | ইন্টারনেট নেই, বা emulator-এর নেট চালু নেই। |

---

# ভাগ ৫: GitHub-এ Push করা

## ৫.১ GitHub অ্যাকাউন্ট বানাও

https://github.com এ গিয়ে Sign up করো (আগে থেকে থাকলে লগইন করো)।

## ৫.২ নতুন repository বানাও

1. GitHub-এ লগইন করে উপরের ডান কোণে **`+`** আইকনে ক্লিক করো → **New repository**
2. **Repository name** দাও: `fake_store_app`
3. **Public** সিলেক্ট করো (স্যার দেখতে পারবেন)
4. ⚠️ **"Add a README file" এ টিক দিও না**
5. ⚠️ **"Add .gitignore" এ টিক দিও না**
6. ⚠️ **"Choose a license" খালি রাখো**

> এই তিনটা টিক দিলে পরের ধাপে conflict হবে। খালি রাখলেই সহজ।

7. **Create repository** ক্লিক করো
8. পরের পেজে একটা URL দেখাবে যেমন:
   `https://github.com/tomarname/fake_store_app.git`
   **এই URL টা কপি করে রাখো** — পরের ধাপে লাগবে।

## ৫.৩ VS Code-এর টার্মিনালে Git চালু করো

`fake_store_app` ফোল্ডারে টার্মিনাল খুলে (Terminal → New Terminal) ধাপে ধাপে লেখো:

**ধাপ ১ — Git চালু করো:**

```
git init
```

**ধাপ ২ — সব ফাইল যোগ করো:**

```
git add .
```

> এখানে `.` মানে "এই ফোল্ডারের সব ফাইল"।

**ধাপ ৩ — প্রথম commit করো:**

```
git commit -m "Initial commit: Fake Store API product catalog app"
```

**ধাপ ৪ — ব্রাঞ্চের নাম main করো:**

```
git branch -M main
```

**ধাপ ৫ — GitHub এর সাথে কানেক্ট করো:**

```
git remote add origin https://github.com/TOMAR-USERNAME/fake_store_app.git
```

> `TOMAR-USERNAME` এর জায়গায় তোমার GitHub username বসাও।
> ঠিক যে URL টা ধাপ ৫.২-এ কপি করেছিলে, সেটাই ব্যবহার করো।

**ধাপ ৬ — push করো:**

```
git push -u origin main
```

এখন একটা উইন্ডো/পপআপ আসবে যেখানে username আর password চাইবে।

> ⚠️ **খুব গুরুত্বপূর্ণ:** এখানে তোমার GitHub **password দিলে কাজ করবে না**।
> GitHub ২০২১ সাল থেকে password দিয়ে push বন্ধ করে দিয়েছে।
> তোমাকে **Personal Access Token (PAT)** ব্যবহার করতে হবে — নিচে দেখো।

## ৫.৪ Personal Access Token বানাও

1. GitHub-এ লগইন করে ডান কোণে প্রোফাইল ছবিতে ক্লিক → **Settings**
2. বাম দিকের মেনু একদম নিচে **Developer settings**
3. **Personal access tokens** → **Tokens (classic)**
4. উপরে **Generate new token** → **Generate new token (classic)**
5. **Note** এ লেখো: `flutter project`
6. **Expiration** এ `30 days` বা `90 days` সিলেক্ট করো
7. **Scopes** এ গিয়ে **`repo`** এর পাশের বক্সে টিক দাও (এটা জরুরি)
8. নিচে **Generate token** ক্লিক করো
9. উপরে একটা লম্বা কোড দেখাবে (`ghp_xxxxxxxxxxxx`) — **এটা কপি করো**

> ⚠️ **এই টোকেনটা একবারই দেখা যাবে।** পেজ থেকে চলে গেলে আর দেখা যাবে না।
> একটা Notepad-এ পেস্ট করে রাখো।

তারপর আবার push করো:

```
git push -u origin main
```

- **Username:** তোমার GitHub username
- **Password:** এখানে **টোকেনটা পেস্ট করো** (পাসওয়ার্ড না!)

> পেস্ট করার সময় টার্মিনালে কিছু দেখা যাবে না — এটা স্বাভাবিক, শুধু
> Ctrl+V করে Enter দাও।

সফল হলে এমন দেখাবে:

```
Enumerating objects: 45, done.
...
To https://github.com/tomarname/fake_store_app.git
 * [new branch]      main -> main
```

এখন GitHub-এ গিয়ে পেজ রিফ্রেশ করলে তোমার সব কোড দেখতে পাবে ✅

## ৫.৫ পরে আবার push করতে হলে

কোডে কোনো পরিবর্তন করার পর এই তিনটা কমান্ডই যথেষ্ট:

```
git add .
git commit -m "Added detail screen improvements"
git push
```

> `git commit -m "..."` এর ভিতরে প্রতিবার কী পরিবর্তন করলে সেটা সংক্ষেপে লেখো।
> স্যারের নিয়মে "meaningful commit messages" চাওয়া হয়েছে, তাই "update" বা
> "fix" এর বদলে "Added search feature" এভাবে লেখো।

---

# ভাগ ৬: APK বানানো (সাবমিশনের জন্য)

সাবমিশনে APK চাওয়া হয়েছে। টার্মিনালে লেখো:

```
flutter build apk --release
```

কয়েক মিনিট লাগবে। শেষ হলে এখানে ফাইলটা পাবে:

```
build\app\outputs\flutter-apk\app-release.apk
```

VS Code-এর বাম দিকের ফাইল লিস্টে এটা navigate করে right-click →
**Reveal in File Explorer** দিয়ে বের করে নাও।

> ⚠️ `flutter build apk` চালানোর আগে অন্তত একবার `flutter run` দিয়ে অ্যাপ
> চালিয়ে দেখা উচিত, যাতে কোনো error লুকিয়ে না থাকে।

---

# পুরো কাজের চেকলিস্ট

- [ ] Flutter ইন্সটল + PATH সেট
- [ ] `flutter doctor` এ সব ঠিক
- [ ] Android Studio + emulator ঠিক
- [ ] VS Code + Flutter extension ইন্সটল
- [ ] Git ইন্সটল + `git config` করা
- [ ] `flutter create fake_store_app`
- [ ] VS Code-এ ফোল্ডার খোলা
- [ ] `lib/` এর ভেতরে ৪টা ফোল্ডার + ৭টা ফাইল
- [ ] `pubspec.yaml` replace করা
- [ ] `flutter pub get` সফল
- [ ] `flutter run` দিয়ে অ্যাপ চালু
- [ ] GitHub-এ repository তৈরি
- [ ] `git init` → `add` → `commit` → `push` সফল
- [ ] `flutter build apk --release` দিয়ে APK বানানো
- [ ] README-তে screenshot যোগ করা

---

# শেষ কথা

প্রথমবার সব করতে ২-৩ ঘণ্টা লাগতে পারে, এটা স্বাভাবিক। কোনো ধাপে আটকে
গেলে error টা কপি করে আমাকে দেখাও — সাথে সাথে সমাধান বলে দেব।

সবচেয়ে বেশি যে জায়গায় মানুষ আটকায়:
1. PATH সেট না করা → `flutter` কমান্ড কাজ করে না
2. GitHub-এ password দিয়ে push করতে চাওয়া → টোকেন লাগে
3. ভুল ফোল্ডার VS Code-এ খোলা → `lib` এর বদলে প্রজেক্ট রুট খুলতে হয়
