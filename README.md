# Magic Hardware

Magic Hardware is a feature-rich e-commerce application built with Flutter. It provides a complete shopping experience, from browsing products to secure checkout.

## Features

* **Authentication:**
    * User registration and login
    * Email Verification
    * Password reset
* **Shop:**
    * Product browsing by category and brand
    * Product search
    * Product details view with image galleries
    * Customer reviews and ratings
    * Wishlist for saving favorite items
* **Personalization:**
    * User profile management
    * Address management

## Developed By

- **Name:** Abdulla Nibah Hussain
- **Batch:** BIT-SD-A8
- **Student ID:** CYX27778

## Getting Started


To get a local copy up and running follow these simple steps.

### Prerequisites

* [Flutter](https://flutter.dev/docs/get-started/install)
* [Firebase](https://firebase.google.com/docs/get-started)

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/TenetNoctis/MagicHardware.git
   ```
2. Install packages
   ```sh
   flutter pub get
   ```
3. Generate Splash Screen & Launcher Icons
   ```sh
   dart run flutter_native_splash:create --path=splash.yaml
   dart run flutter_launcher_icons
   ```
4. Run the app
   ```sh
   flutter run
   ```

## Firebase Setup

1. Go to the [Firebase console](https://console.firebase.google.com/) and create a new project.
2. Add an Android app to your Firebase project with the package name `com.magichardware.magic_hardware`.
3. Download the `google-services.json` file and place it in the `android/app` directory.
4. If you are building for iOS, also add an iOS app to your Firebase project and follow the instructions to add the `GoogleService-Info.plist` file to your Xcode project.

## Documentation

To view the project documentation, run the following commands:

```sh
dart pub get
dart doc .
dart pub global activate dhttpd
dart pub global run dhttpd --path doc/api
```

To then read the generated docs in your browser, open the link that `dhttpd` outputs, usually http://localhost:8080.

## Folder Structure

The project is structured following the principles of clean architecture.

```
lib
├── bindings
│   └── general_bindings.dart
├── common
│   ├── styles
│   └── widgets
├── data
│   ├── dummy_data
│   └── repositories
├── features
│   ├── authentication
│   ├── personalization
│   └── shop
├── routes
│   ├── app_routes.dart
│   └── routes.dart
├── utils
│   ├── constants
│   ├── device
│   ├── exceptions
│   ├── formatters
│   ├── helpers
│   ├── http
│   ├── local_storage
│   ├── logging
│   ├── popups
│   ├── theme
│   └── validators
├── app.dart
├── firebase_options.dart
├── main.dart
└── navigation_menu.dart

```
