# flutter_boiler_plate

A flutter boiler plate code for faster development time

### [DEV'S NOTE ONLY] Branch management

- Any new change will be made in [master] branch first
- After change done, merge [master] into [bottom-navigation] then merge [bottom-navigation] into [user-authentication]
- **Must not merge any branch to master**

# Getting Started

1. create your own project with android studio or **flutter create** command ( to prevent package name redundancy )
2. copy folder **assets**, **lib**,**resources**, and **pubspec.yaml** from this project to your newly created project and replace all file
3. run **flutter pub get**

# App Icon

1. if you want to generate app icon,replace your icon file in **assets/image/app-icon.png** then run the following command: **flutter pub run flutter_launcher_icons:main**

2. run **flutter packages pub run build_runner build** to generate Hive TypeAdapter model

# Project folder structure

## lib

### api_service

- create your api service class which extends BaseApiService here

### bloc

- create your own bloc or use existing BaseStream and BaseStreamConsumer to consume your Rest Api with stream

### constant

- contain your constant file here such as TextStyle, Height, Dimension,.....

### enum

- create your enum here

### model

- response: your mapping response model from api here
- request: your own model class to request api
- db: model for hive or any database's model
- save your common user data model

### pages

- Each page has their own folder
- Each folder has a .dart file and a widgets folder that contains a widget that only use specifally in this page

### provider

- contain your provider classes

### service

- service provider class such as: ImagePickerService ,DialogService, NavigationService.....

### utils

- utility function or class

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
  > run this file with **dart generator.dart** to generate ImageAssets class to access your images path, Example usage: Image.asset(ImageAssets.icon)
