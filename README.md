# Class Manager (Flutter + Firebase)

Cross-platform app for teachers and students to manage classes, attendance, quizzes, grades, content sharing, and analytics. Built with Flutter, Riverpod, and Firebase.

## Quick start

1. Install Flutter (stable) and Dart SDK.
2. Create Firebase project and add Android/iOS/Web apps.
3. Configure Firebase to generate `lib/firebase_options.dart`:

```bash
flutter pub get
dart pub global activate flutterfire_cli
flutterfire configure --project <YOUR_PROJECT_ID>
```

This generates `lib/firebase_options.dart` with `DefaultFirebaseOptions`.

4. Enable Firebase services:
   - Authentication (Email/Password)
   - Cloud Firestore
   - Cloud Storage
   - Cloud Messaging (for notifications)

5. Run the app:

```bash
flutter run
```

## Project structure

```
lib/
  main.dart
  src/
    app.dart
    core/
      theme/app_theme.dart
      router/app_router.dart
      firebase/firebase_init.dart
      providers/firebase_providers.dart
    models/
      user_model.dart
      class_model.dart
      attendance_record.dart
      quiz_model.dart
      question_model.dart
      grade_model.dart
      content_item.dart
    services/
      auth_service.dart
      firestore_service.dart
      attendance_service.dart
      quiz_service.dart
      grades_service.dart
      content_service.dart
      notifications_service.dart
      offline_sync_service.dart
    features/
      auth/login_screen.dart
      dashboards/teacher_dashboard_screen.dart
      dashboards/student_dashboard_screen.dart
      attendance/attendance_screen.dart
      quizzes/quiz_creator_screen.dart
      quizzes/quiz_take_screen.dart
      grades/grades_screen.dart
      content/content_screen.dart
```

## Roles
- Teacher: create classes, manage students, attendance, quizzes, grades, content
- Student: view dashboard, take quizzes, see attendance and grades, view content

## Notes
- Offline mode uses local queue in `offline_sync_service.dart` with `shared_preferences` as a simple example. You can replace with Hive/SQLite for robustness.
- Video playback uses `video_player` and `chewie`.
- Charts use `fl_chart`.