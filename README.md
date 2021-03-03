# flutter_boiler_plate

A flutter boiler plate code for initial project setup

# Getting Started

1. create your own project with Android studio or **flutter create** command

2. copy these files or folder into your new project

- assets
- lib
- test
- pubspec.yaml
- analysis_options.yaml (optional)

3. This files is optional if you're using flavor

- flutter_launcher_icons-prod.yaml
- flutter_launcher_icons-dev.yaml
- flutter_launcher_icons-staging.yaml

4. delete all firebase dependency in pubspec.yaml if you're not planing using firebase

5. run **flutter pub get**
6. **In [project]/android/app/build.gradle set minSdkVersion to >= 18 to use flutter_secure_storage**
7. You can copy any platform configuration setup (example: build.gradle, androidManifest) from this project into your new project

# App Icon
- replace your icon file in **assets/image/app-icon.png** then run the following command: **flutter pub run flutter_launcher_icons:main**

# Hive database

2. run **flutter packages pub run build_runner build** to generate Hive TypeAdapter model

# Project folder structure

## lib

### api_service

- create your api service class which extends BaseApiService here

### constant

- contain your constant file here such as TextStyle, Color, Theme, Asset path, LocaleKeys, Enum, Height, Dimension,.....

### model

- response: your mapping response model from api here
- request: your own model class to request api
- db: model for hive or any database's model
- others: other model such as custom data

### page_template

- a template for commonly use screen or page functioanlity in an app, example: change password page, setting page....

### pages

- Each page has their own folder
- Each folder has a .dart file and a widgets folder that contains a widget that only use specifally in this page

### providers

- contain your provider classes

### services

- service provider class such as: ImagePickerService, DialogService, NavigationService.....

### utils

- utility function and class

### widgets

- global reusable widget and divide to into folder of category such as Dialog,Card,Button,Loading.....etc

## assets

- fonts
  > this is where you keep your font
- images

  > this is where you keep your image asset

- language

  > this is where you keep your localization file

- generator
  > run this file with **dart generator.dart** to generate AppAssets class to access your images path, Example usage: Image.asset(AppAssets.icon)
