<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Read SMS Package for Flutter  

This package provides an easy way to **fetch SMS messages** from a user's device and send them to a server. It simplifies SMS integration in Flutter projects, allowing developers to access and process SMS data effortlessly.  

## Features  

✅ Fetch SMS messages from the user's device.  
✅ Send SMS data to a server.  
✅ Handles necessary permissions for reading SMS.  

## Installation  

To use this package, add the following dependency to your `pubspec.yaml` file:  

```yaml
dependencies:
  flutter_read_inbox: ^0.0.1
```

Then, run:  

```sh
flutter pub get
```

## Getting Started  

To start using this package, you must **add the required permissions** in your Android project's `AndroidManifest.xml` file:  

```xml
<uses-permission android:name="android.permission.SEND_SMS"/>
<uses-permission android:name="android.permission.RECEIVE_SMS"/>
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.READ_CONTACTS"/>
<uses-permission android:name="android.permission.READ_PROFILE"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

## Usage  

Import the package:  

```dart
import 'package:read_sms/src/read_inbox.dart';
```

### Request Permissions and Fetch SMS  

```dart
final ReadInbox readInbox = ReadInbox();

// Request necessary permissions
readInbox.readInboxData();
```

## Example  

For a complete example, check the `/example` folder.  

## Additional Information  

- **Issues & Contributions:** If you find any issues or want to contribute, visit the [GitHub repository](https://github.com/TaashaMobile/read_sms).  
- **Support:** If you need help, open an issue or reach out via [email](mailto:ketan.taasha@gmail.com).  

🚀 **Enjoy seamless SMS integration in your Flutter project!** 🚀  
