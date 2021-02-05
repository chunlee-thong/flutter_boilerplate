# flutter_boiler_plate

A flutter boiler plate code initial project setup

### [DEV'S NOTE ONLY] Branch management

- Any new change will be made in [master] branch first
- After change has been push, merge [master] into [bottom-navigation] then merge [bottom-navigation] into [user-authentication]
- **Must not merge any branch to master**

# Getting Started

1. create your own project with android studio or **flutter create** command ( to prevent package name redundancy )
2. copy folder **assets**, **lib**, and **pubspec.yaml** from this project to your newly created project and replace all file
3. run **flutter pub get**
4. **In [project]/android/app/build.gradle set minSdkVersion to >= 18 to use flutter_secure_storage**

# App Icon

1. if you want to generate app icon,replace your icon file in **assets/image/app-icon.png** then run the following command: **flutter pub run flutter_launcher_icons:main**

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
