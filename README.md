# Flutter XR


![](docs/raw/Flutter_XR_0.0.2-dev_Demo_theshivamlko_navoki-min.jpg)



> Flutter XR plugin powered by the Android XR SDK build immersive 2D apps for Android XR with familiar Flutter widgets, with utilizing the Spatial Environment provided by Android XR devices.

## NOTE:
⚠️ NOT FOR PRODUCTION 

This is POC (Proof-Of-concept) that flutter app can run and execute code on Android XR SDK. Still plugin has known issues.

`flutter_xr` lets you embed existing Flutter UI and Dart code logics into an Android XR environment. It wraps the Android XR SDK so you can stay in Flutter while targeting spatial / XR devices.

`flutter_xr` uses [pigeon](https://pub.dev/packages/pigeon) for type‑safe platform channels.

[Flutter XR](https://github.com/theshivamlko/flutter_xr)

[Android XR SDK](https://developer.android.com/develop/xr/get-started)


> **Status:** In active development (Dev‑Mode). APIs may change.

---

## Features

- 🧩 **Flutter UI**  
  Main Panel: Make UI with any Flutter `Widget` for 2D app and Logics with Dart Programming

- 🧭 **Orbit‑based layout**  
  Define separate Flutter widgets for **left**, **right**, **top**, and **bottom** orbits in XR. Currently these are not dynamic, may be in future.
   [Orbiter](https://developer.android.com/reference/kotlin/androidx/xr/compose/spatial/package-summary#Orbiter)

- 📱 **Shared 2D & XR UI patterns**  
  Reuse the same components (bottom nav, search bar, lists, feeds) both in classic 2D mode and XR surfaces.

- 📱 **Route base UI for different panels **  
  Use named routes to set different view on separate orbits

- 🧪 **Example app included**  
  The `example/` app shows:
  - A **bottom navigation bar** (Explore / Go / Saved / Contribute)
  - A **search bar** orbit
  - A **feed/list** orbit styled like a social / recommendations UI
  - Spatial Permission to enable orbit

---

## Prerequisite
1. [Flutter](https://flutter.dev/)
2. [Android Studio](https://developer.android.com/studio) Otter 2 Feature Drop | 2025.2.2 or above
3. Android XR Headset emulator with API 34 Google Play Store


## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_xr: ^0.0.2-dev
```

Then fetch dependencies:

```bash
flutter pub get
```

---

## Example

A complete sample is provided in the `example/` directory.

From the root of this repo:

```bash
cd example
flutter pub get
flutter run
```


## Usage

### 1. Import the plugin

```dart
import 'package:flutter_xr/flutter_xr.dart';
```

### 2. Main Panel UI , without Orbits
Just use same Flutter app as it is, no changes are required. The app run has normal Table app in Android XR. 

**Technically u don't need plugin for Simple UI App , but for accessing Android XR SDK Native apis u can use this plugin**
```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}
```



### 2. Main Panel UI , With Orbits
The plugin provides 4 Orbiter with named routes. Named routes labels are fixed.

```dart
"/" => MainApp()
"/left" => LeftOrbitWidget()
"/right" => RightOrbitWidget()
"/top" => TopOrbitWidget()
"/bottom" => BottomOrbitWidget()
```

In your app, you can keep each orbit in its own widget file.

```dart
// left_orbit.dart
import 'package:flutter/material.dart';
import 'package:flutter_xr/flutter_xr.dart';
import 'dart:async';

final _flutterXrPlugin = FlutterXr();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// register routes on native side to show widgets in orbit
  /// leftOrbit, rightOrbit, topOrbit, bottomOrbit
  /// registerRoutes() will return a routes to be used in MaterialApp
  final appRoutes = await _flutterXrPlugin.registerRoutes(
    leftOrbit: Orbiter(
      ContentEdge.start,
      Alignment.centerVertically,
      OrbiterOffsetType.innerEdge,
      LeftOrbit(),
      width: 100,
      height: 100,
    ),
    rightOrbit: Orbiter(
      ContentEdge.end,
      Alignment.centerVertically,
      OrbiterOffsetType.innerEdge,
      RightOrbit(),
      width: 100,
      height: 100,
    ),
    topOrbit: Orbiter(
      ContentEdge.top,
      Alignment.centerHorizontally,
      OrbiterOffsetType.innerEdge,
      TopOrbit(
        onSearchChanged: (String value) {
          print("topOrbit $value");
        },
      ),
      width: 100,
      height: 100,
    ),
    bottomOrbit: Orbiter(
      ContentEdge.bottom,
      Alignment.centerHorizontally,
      OrbiterOffsetType.innerEdge,
      BottomOrbit(),
      width: 100,
      height: 100,
    ),
  );

  /// Set appRoutes in MaterialApp, routes label as fixed in plugin
  runApp(
    MaterialApp(
      home: MyApp(),
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
```


### 3. Check for spatial capabilities is Enabled

```dart
Future<void> checkSpatialEnabled() async {
  try {
   bool isSpatialEnabled = await _flutterXrPlugin.isSpatialUiEnabled();
  } on PlatformException catch (e) {
    print(e);
  }
}
```

### 4. Transition from Home Space to Full Space

A user can experience your app in two modes, Home Space or Full Space. In Home Space, a user is able to multitask with your app running side by side with other apps. In Full Space, your app takes center stage as the focus of the user's experience with full access to the immersive capabilities of Android XR.

```dart
  void toggleSpatialFullScreen() async {
  if (isSpatialEnabled) {
    await _flutterXrPlugin.requestHomeSpaceMode();
  } else {
    await _flutterXrPlugin.requestFullSpaceMode();
  }
}
```

To set the default mode at launch set default mode in `AndroidManifest.xml`
```xml
<activity
<!-- Launch in Full Space. -->
    <property
       android:name="android.window.PROPERTY_XR_ACTIVITY_START_MODE"
       android:value="XR_ACTIVITY_START_MODE_FULL_SPACE_MANAGED" />
    
    <!-- Or, launch in Home Space. -->
    <property
       android:name="android.window.PROPERTY_XR_ACTIVITY_START_MODE"
       android:value="XR_ACTIVITY_START_MODE_HOME_SPACE" />
<activity/>
```

---

## Android XR setup

This plugin is currently focused on **Android XR SDK**.

1. Open `android/app/build.gradle` in your app and ensure that the minimum and target SDK versions match the requirements of your XR device or emulator.
2. Check the plugin’s `android/` folder for the exact Gradle configuration and XR SDK dependencies.
3. Build and run on an XR‑capable device or emulator.

Because platform requirements evolve quickly, you should always verify against the latest Android XR SDK documentation.

---
 
## Roadmap

- More XR layouts (panels, floating windows, radial menus)
- Better navigation and state patterns for multi‑orbit XR apps
- Additional platform support (visionOS / iOS / desktop / web) where meaningful
- More polished sample experiences and documentation

---

## License

This project is licensed under the terms specified in [`LICENSE`](LICENSE).
