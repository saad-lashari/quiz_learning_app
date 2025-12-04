# Quiz Learning App

Lightweight Flutter quiz app demonstrating a feature-first architecture, BLoC state management, and responsive UI for mobile, web and desktop.

## Features
- Quiz categories and questions
- Progress tracking per user and category
- Responsive home layout 
- BLoC-based state management

## 1. Dependencies Used

*   **dio**: Used for API's calling .
*   **dartz**: For functional error handling.
*   **go_router**: For navigation
*   **equatable**: For value comparison
*   **flutter_screenutil**: To make the UI responsive across different screen sizes.
*   **flutter_bloc** & **bloc**: For state management using the BLoC pattern, separating business logic 

## 2. Project Structure

The project follows a feature-first architecture, with a core directory for shared components.

```
lib/
 ├── core/
 │   ├── constants/   # Contains application-wide constants like colors and image paths.
 │   └── utils/       # Holds utility functions.
 │   
 ├── features/      # Contains the different features of the application, separated by domain.
 │   ├── dashboard/
 │   ├── home/
 │   └── quiz/
 └── main.dart      # The entry point of the application.
```

## 3. App Screenshots

<p align="center">
  <img src="screenshots/1.png" alt="Home Page" width="200" style="margin: 10px; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" />
  <img src="screenshots/2.png" alt="Count Down" width="200" style="margin: 10px; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" />
  <img src="screenshots/3.png" alt="Question Card" width="200" style="margin: 10px; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" />
  <img src="screenshots/4.png" alt="Answer Card" width="200" style="margin: 10px; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" />
  <img src="screenshots/5.png" alt="Quiz Completion" width="200" style="margin: 10px; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" />
</p>

## Getting started

Prerequisites:
- Flutter SDK (stable channel)

Install dependencies:

```bash
flutter pub get
```

Run the app (mobile):

```bash
flutter run -d <device_id>
```

Run for web (Chrome):

```bash
flutter run -d chrome
```

Run for macOS (desktop):

```bash
flutter run -d macos
```

Run tests:

```bash
flutter test
```

Tests added:
- `test/unit/is_small_device_test.dart` — unit tests for the responsive helpers
- `test/widget/category_card_test.dart` — widget test ensuring `CategoryCard` renders correctly


## 4. App Video

[Watch Video](https://drive.google.com/file/d/1gThczp9fM627nGOIFX-EIO4J84utj0ni/view?usp=sharing)



## 5. App APK

[Download APK](https://drive.google.com/file/d/1krZD-MG36VpFMV0_PoK8smnbVm71JdLr/view?usp=sharing)

