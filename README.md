# Flutter Todo List App

A production-ready Todo app built with Flutter, Firebase, Riverpod, Material 3, Sentry, and Hive.

## Features
- Google Sign-In (Firebase Auth)
- Task CRUD (title, description, due date, status, priority)
- Riverpod state management
- Material 3 UI
- Swipe-to-delete, pull-to-refresh
- Priority color coding
- Offline-first (Hive)
- Sentry crash reporting

## Setup Instructions
1. Clone the repo
2. Run `flutter pub get`
3. Add your Firebase config files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS)
4. Run the app: `flutter run`

## Folder Structure
```
/lib
  /models         # Task model
  /providers      # Riverpod providers
  /services       # Auth, Database
  /screens        # Login, TaskList, AddEditTask
  /widgets        # Reusable components
  main.dart       # App entry
```

## Hackathon Attribution
This project is part of a hackathon by [katomaran.com](https://www.katomaran.com)

## Architecture Diagram
(Insert Loom video and diagram here) 

---

## 1. **Firebase Setup (Flutter + Google Sign-In)**

### **A. Firebase Console**
1. Go to [Firebase Console](https://console.firebase.google.com/).
2. **Create a new project** (or use an existing one).
3. **Add an Android app**:
   - Enter your app’s package name (e.g., `com.example.todo_list_app`).
   - Download `google-services.json` and place it in `android/app/`.
4. **Add an iOS app** (if needed):
   - Enter your iOS bundle identifier.
   - Download `GoogleService-Info.plist` and place it in `ios/Runner/`.
5. In the Firebase Console, go to **Authentication > Sign-in method** and enable **Google**.

### **B. Flutter Project**
1. In your `pubspec.yaml`, you already have:
   - `firebase_core`
   - `firebase_auth`
   - `google_sign_in`
2. In `android/build.gradle` and `android/app/build.gradle`, ensure Google services are applied (see [FlutterFire docs](https://firebase.flutter.dev/docs/installation/android)).
3. In `main.dart`, you already have:
   ```dart
   await Firebase.initializeApp();
   ```
4. **Test Google Sign-In**: Run the app, tap “Sign in with Google.” If you see the Google account picker, it’s working!

---

## 2. **Hive Integration (Offline-First Local Storage)**

### **A. Setup**
1. You already have `hive` and `hive_flutter` in `pubspec.yaml`.
2. In `main.dart`, you already have:
   ```dart
   await Hive.initFlutter();
   ```
3. **Register Adapters** (for custom objects like `Task`):
   - In `main.dart` (after `Hive.initFlutter()`):
     ```dart
     Hive.registerAdapter(PriorityAdapter());
     Hive.registerAdapter(TaskAdapter());
     ```
   - You need to generate the adapters:
     - Add `build_runner` and `hive_generator` to `dev_dependencies` in `pubspec.yaml`:
       ```yaml
       dev_dependencies:
         build_runner: ^2.4.6
         hive_generator: ^2.0.1
       ```
     - Run:
       ```
       flutter pub get
       flutter packages pub run build_runner build
       ```
     - This generates `task.g.dart` in your `models` folder.

### **B. Using Hive in Your App**
- **Open a box** (e.g., in your provider or service):
  ```dart
  var box = await Hive.openBox<Task>('tasksBox');
  ```
- **CRUD Example**:
  ```dart
  // Add
  await box.put(task.id, task);

  // Read
  List<Task> tasks = box.values.toList();

  // Update
  await box.put(task.id, updatedTask);

  // Delete
  await box.delete(task.id);
  ```
- **Sync with Riverpod**: On app start, load tasks from Hive into your provider. On any change, update Hive.

---

## **Summary Table**

| Step                | Firebase                                    | Hive (Offline)                |
|---------------------|---------------------------------------------|-------------------------------|
| Console Setup       | Create project, add app, enable Google Auth | N/A                           |
| Config Files        | `google-services.json`, `GoogleService-Info.plist` | N/A                    |
| Flutter Packages    | `firebase_core`, `firebase_auth`, `google_sign_in` | `hive`, `hive_flutter` |
| Initialization      | `Firebase.initializeApp()`                   | `Hive.initFlutter()`          |
| Adapters            | N/A                                         | Register & generate adapters  |
| Usage               | Use AuthService, Firestore, etc.            | Open box, CRUD with box       |

---

## **Want code samples for:**
- Loading/saving tasks with Hive?
- Syncing between Firebase and Hive?
- Anything else (e.g., Firestore integration)?

Let me know which part you want to see in detail! 

---

## 1. **Dependency Version Conflict**

**Error:**
```
Because every version of flutter_test from sdk depends on material_color_utilities 0.11.1 and todo_list_app depends on material_color_utilities ^0.5.0, flutter_test from sdk is forbidden.
So, because todo_list_app depends on flutter_test from sdk, version solving failed.
```

**Solution:**  
Update your `pubspec.yaml` to use the compatible version:
```yaml
material_color_utilities: ^0.11.1
```
**Remove** or **update** the old line:
```yaml
# material_color_utilities: ^0.5.0  # <-- Remove or update this line
material_color_utilities: ^0.11.1   # <-- Add this line
```
Then run:
```
flutter pub get
```

---

## 2. **No Supported Devices Connected**

**Error:**
```
No supported devices connected.
The following devices were found, but are not supported by this project:
Windows (desktop) • windows • windows-x64
Chrome (web)      • chrome  • web-javascript
Edge (web)        • edge    • web-javascript
If you would like your app to run on web or windows, consider running `flutter create .` to generate projects for these platforms.
```

**Solution:**  
- **For Android/iOS:** Connect a physical device or start an emulator/simulator.
- **For Web/Desktop:**  
  If you want to run on web or Windows desktop, run:
  ```
  flutter create .
  ```
  This will generate the necessary files for those platforms.

---

## **Summary Table**

| Issue                        | Solution                                      |
|------------------------------|-----------------------------------------------|
| Dependency conflict          | Update `material_color_utilities` to ^0.11.1  |
| No supported devices         | Connect device, start emulator, or run `flutter create .` for web/desktop support |

---

**Next Steps:**
1. Update your `pubspec.yaml` as above and run `flutter pub get`.
2. Connect a device or run an emulator, or run `flutter create .` for web/desktop.
3. Try `flutter run` again.

Let me know if you need help with any of these steps! 