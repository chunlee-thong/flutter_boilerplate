# flutter_boiler_plate

A flutter boiler plate code for initial project setup

### What we provided and use in this project

- A folder structure and some widgets
- Theme switch (dark and light mode)
- Pages
  - Login page
  - Home page
  - Some page templates

---

- [easy_localization](https://pub.dev/packages/easy_localization) for localization
- [Provider](https://pub.dev/packages/provider) for State management and context based DI
- [Dio](https://pub.dev/packages/dio) for http client
- [Hive](https://pub.dev/packages/hive) database for structural local storage and
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- [shared_preferences](https://pub.dev/packages/shared_preferences) for key value local storage
- [get_it](https://pub.dev/packages/get_it) for service locator and DI
- Some others useful packages

## Getting Started

1. create your own project with Android Studio or **flutter create** command

2. copy these files and folder into your new project

- assets
- lib
- test
- pubspec.yaml
- analysis_options.yaml (optional)
- README.md (optional)

3. if you are using flavor

- change bundle id and app name in **pubspec.yaml**
- run **flutter pub run flutter_flavorizr -p assets:download,assets:extract,ios:xcconfig,ios:buildTargets,ios:schema,ios:plist,assets:clean,ide:config,android:buildGradle,android:androidManifest** to generate flavor config for ios and android if you're using flavor.
- copy these files for a different launcher icon base on flavor

  - flutter_launcher_icons-prod.yaml
  - flutter_launcher_icons-dev.yaml
  - flutter_launcher_icons-staging.yaml

4. copy .github folder if you're using github action

5. delete all firebase dependency in pubspec.yaml if you're not using firebase

6. run **flutter pub get**
7. **In [project]/android/app/build.gradle set minSdkVersion to >= 18 to use flutter_secure_storage**
8. You can copy any platform configuration setup (example: build.gradle, androidManifest) from this project into your new project

## App Icon

- replace your icon file in **assets/image/app-icon.png**
- run: **flutter pub run flutter_launcher_icons:main**
- if there is an error, change *minSdkVersion* and *targetSdkVersion* in android app gradle to integer instead
- note: this command will run all flutter_launcher_icon with flavor if you have any
- App Icon isn't dynamic by flavor in ios. you need to replace a String ""$(ASSET_PREFIX)AppIcon";" to ""$(ASSET_PREFIX)AppIcon"-$(ASSET_PREFIX);" in ios/project.pbxproj

## Hive database

2. run **flutter packages pub run build_runner build** to generate Hive TypeAdapter model

## Integration test
*flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart --flavor dev*

## Project folder structure

### lib/src

#### controllers
- Controllers to manage app state

#### core
- constant
- http configuration
- app style (color, theme, textstyle, decoration, size)
- utilities and helper class

#### model

- response: your mapping response model from api
- request: your own model class to request api
- db: model for hive or any database's model
- others: custom object model

#### pages

- Each page has their own folder
- Each folder has a .dart file and a widgets folder that contains a widget that only use specifally in this page


#### repository

- class that use to fetch data from Data source

#### services

- mostly static class for some specific feature
  - example:
    - notifications service
    - database or storage service
    - auth service .....


#### widgets

- global reusable widget and divide to into folder of category such as Dialog, Card, Button, Layout.....etc

### assets

- fonts
  > this is where you keep your font
- images

  > this is where you keep your image asset

- language

  > this is where you keep your localization file

- generator
  > run this file with **dart generator.dart** to generate AppAssets class to access your images path, Example usage: Image.asset(AppAssets.icon)
