# flutter_boiler_plate V1.1.0

A flutter boiler plate code for initial project setup

## _Note_

_this project hasn't migrate to null-safety yet._

### What we provided and use in this project

- A folder structure and resuable some widgets
- Theme switch (dark and light mode)
- Pages
  - Login page
  - Home page
  - Some page templates

---

- Localization (using: [easy_localization](https://pub.dev/packages/easy_localization))
- State management with [Provider](https://pub.dev/packages/provider)
- [Dio](https://pub.dev/packages/dio) for http client
- [Hive](https://pub.dev/packages/hive) database for structural local storage and [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) and [shared_preferences](https://pub.dev/packages/shared_preferences) for key value local storage
- [get_it](https://pub.dev/packages/get_it) for service locator
- Some others popular package

## Getting Started

1. create your own project with Android studio or **flutter create** command

2. copy these files or folder into your new project

- assets
- lib
- test
- pubspec.yaml
- analysis_options.yaml (optional)

3. copy these files if you're using flavor and want a different launcher icon for your flavor

- flutter_launcher_icons-prod.yaml
- flutter_launcher_icons-dev.yaml
- flutter_launcher_icons-staging.yaml

4. copy .github folder if you're using github action

5. delete all firebase dependency in pubspec.yaml if you're not using firebase

6. run **flutter pub get**
7. **In [project]/android/app/build.gradle set minSdkVersion to >= 18 to use flutter_secure_storage**
8. You can copy any platform configuration setup (example: build.gradle, androidManifest) from this project into your new project

## App Icon

- replace your icon file in **assets/image/app-icon.png** then run the following command:
**flutter pub run flutter_launcher_icons:main**
- note: this command will run all flutter_launcher_icon with flavor if you have any

## Hive database

2. run **flutter packages pub run build_runner build** to generate Hive TypeAdapter model

## Project folder structure

### lib

#### api_service

- create your api service class which extends BaseApiService here

#### constant

- contain your constant file here such as TextStyle, Color, Theme, Asset path, LocaleKeys, Enum, Height, Dimension,.....

#### model

- response: your mapping response model from api here
- request: your own model class to request api
- db: model for hive or any database's model
- others: other model such as custom data

#### page_template

- a template for commonly use screen or page functioanlity in an app, example: change password page, setting page....

#### pages

- Each page has their own folder
- Each folder has a .dart file and a widgets folder that contains a widget that only use specifally in this page

#### providers

- contain your provider classes

#### services

- service provider class such as: ImagePickerService, DialogService, NavigationService.....

#### utils

- utility function and class

#### widgets

- global reusable widget and divide to into folder of category such as Dialog,Card,Button,Loading.....etc

### assets

- fonts
  > this is where you keep your font
- images

  > this is where you keep your image asset

- language

  > this is where you keep your localization file

- generator
  > run this file with **dart generator.dart** to generate AppAssets class to access your images path, Example usage: Image.asset(AppAssets.icon)
