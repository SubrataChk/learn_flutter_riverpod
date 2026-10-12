# Project Structure (Riverpod — Feature-First)

এই প্রজেক্টটা **feature-first** pattern follow করে — মানে প্রতিটা feature (screen/module)-এর
নিজের ভিতরেই তার UI, state, এবং (দরকার হলে) data/domain লজিক থাকে। একটা feature বড় হলেও
অন্য feature-কে touch করতে হয় না।

```
lib/
├── main.dart                 # App এর entry point
├── app.dart                  # MaterialApp + ScreenUtilInit + root theme
├── core/                     # পুরো app জুড়ে ব্যবহৃত জিনিস (feature-specific না)
│   └── theme/
│       └── app_theme.dart    # ThemeData (colors, AppBar style ইত্যাদি)
├── features/                 # প্রতিটা feature/screen এর নিজস্ব ফোল্ডার
│   └── counter/
│       ├── data/             # (খালি, placeholder) API/local-storage কল — repository ইত্যাদি
│       ├── domain/           # (খালি, placeholder) business models / entities
│       ├── application/      # Riverpod providers — state ও business logic
│       │   └── counter_provider.dart
│       └── presentation/     # UI — শুধু provider read/watch করে, logic রাখে না
│           ├── screens/
│           │   └── counter_screen.dart
│           └── widgets/
│               └── counter_display.dart
└── shared/
    └── widgets/               # (খালি, placeholder) একাধিক feature জুড়ে reuse হওয়া widget
```

## প্রতিটা ফাইল কিসের জন্য

| ফাইল | কাজ |
|---|---|
| `main.dart` | App শুরু হয় এখান থেকে। শুধু `ProviderScope` দিয়ে `MyApp` কে wrap করে `runApp` করা হয় — Riverpod এর সব provider এই `ProviderScope`-এর নিচেই কাজ করে। |
| `app.dart` | `MyApp` widget — `ScreenUtilInit` (responsive sizing initialize করে) এবং তার ভিতরে `MaterialApp` (theme, home screen সেট করা)। |
| `core/theme/app_theme.dart` | App-wide `ThemeData` — রঙ, AppBar style ইত্যাদি। নতুন theme/dark-mode লাগলে এখানে যোগ হবে। |
| `features/counter/application/counter_provider.dart` | **State + logic**। `Notifier<int>` ক্লাস দিয়ে counter এর value এবং `increment()`/`reset()` মেথড রাখা হয়েছে। UI সরাসরি state বদলায় না — শুধু এই মেথডগুলো কল করে। |
| `features/counter/presentation/screens/counter_screen.dart` | পুরো screen (Scaffold, AppBar, FloatingActionButton)। `ConsumerWidget` ব্যবহার করে provider এর সাথে connect হয়। |
| `features/counter/presentation/widgets/counter_display.dart` | শুধু counter number দেখানোর widget। আলাদা widget-এ রাখার কারণ: counter বাড়লে শুধু এইটুকু widget rebuild হবে, পুরো screen না — performance ভালো থাকে। |
| `features/counter/data/`, `features/counter/domain/` | এখনো খালি। যেদিন counter feature-এ API call বা local storage লাগবে (যেমন: counter value server-এ save করা), repository class `data/`-তে আর model class `domain/`-এ রাখবে। |
| `shared/widgets/` | এখনো খালি। একাধিক feature-এ reuse হবে এমন widget (যেমন: custom button, loading indicator) এখানে রাখবে। |

## নতুন feature যোগ করতে চাইলে

হাতে বানানোর দরকার নেই — একটা script আছে যেটা পুরো feature folder + boilerplate auto generate করে দেয়:

```bash
./scripts/create_feature.sh todo
./scripts/create_feature.sh user_profile   # multi-word নামও চলবে (snake_case/space/CamelCase যেভাবেই দাও)
```

এটা `lib/features/<name>/` এর নিচে `data/`, `domain/`, `application/`, `presentation/{screens,widgets}`
বানিয়ে দেবে, আর `application/<name>_provider.dart` + `presentation/screens/<name>_screen.dart`
ফাইলে counter feature-এর মতো একই pattern-এ (Notifier + NotifierProvider + ConsumerWidget,
ScreenUtil সহ) একটা কাজ-চলা boilerplate লিখে দেবে। এরপর শুধু:

1. জেনারেট হওয়া `<Name>Notifier`-এ তোমার আসল state/logic বসাও।
2. জেনারেট হওয়া `<Name>Screen` UI সাজাও।
3. `app.dart` (বা router) থেকে নতুন screen-টা call করো।

Script already exist করা feature-এর নাম দিলে overwrite করবে না — এরর দেখাবে।

## State management — Riverpod pattern

- **Provider** (`counterProvider`) = state + logic এর entry point।
- **Notifier** (`CounterNotifier`) = state এর initial value (`build()`) এবং সেটা বদলানোর মেথড।
- **`ref.watch(provider)`** = UI-তে ব্যবহার করো, যখন value পরিবর্তনে widget rebuild হওয়া দরকার।
- **`ref.read(provider.notifier)`** = শুধু একটা action trigger করতে (যেমন বাটন-এর `onPressed`), rebuild দরকার নেই।

## Responsive design — `flutter_screenutil`

`app.dart`-এ `ScreenUtilInit(designSize: Size(390, 844), ...)` দিয়ে একটা reference screen size
সেট করা আছে (iPhone 13 এর সমান)। এরপর যেকোনো widget-এ:

- `16.w` → width অনুযায়ী scaled value
- `16.h` → height অনুযায়ী scaled value
- `16.sp` → font size, screen size অনুযায়ী scaled
- `16.r` → radius (BorderRadius ইত্যাদির জন্য)

ব্যবহার করলে ছোট/বড় সব screen-এ (ফোন, ট্যাব) সঠিক অনুপাতে UI দেখাবে। Hard-coded pixel value
(যেমন `fontSize: 16`) এড়িয়ে সবসময় এই extension গুলো ব্যবহার করবে।
