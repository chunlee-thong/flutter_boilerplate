# flutter_boiler_plate

A flutter boiler plate code for faster development time

# Getting Started

1. create your own project with android studio or **flutter create** command ( to prevent package name redundancy )
2. copy folder **assets**, **lib**,**resources**, and **pubspec.yaml** from this project to your newly created project and replace all file
3. run **flutter pub get**

# App Icon

1. if you want to generate app icon,replace your icon file in **assets/image/app-icon.png** then run the following command: **flutter pub run flutter_launcher_icons:main**

# Project folder structure

## lib

### api_service

    - create your api service class which extends BaseApiProvider here

### bloc

    - create your own bloc or use existing BaseStream and BaseStreamConsumer to consume your Rest Api with stream

### constant

    - contain your constant file here such as TextStyle, Height, Dimension,.....

### enum

    - create your enum here

### model

    - response: contain your mapping response model from api here
    - request: contain your own mode class to request api
    - save your common user data model

### pages

    - Each page has their own folder
    - Each folder has a page file and a widgets folder that contains a widget that only use in that [age]

### provider

    - contain your provider classes

### service

    - create your service class

### utils

### widgets

## assets

- fonts
  > this is where you keep your font
- images
  > this is where you keep your image asset
- generator
  > run this file with **dart generator.dart** to generate class R and Image to access your images path, Example usage: Image.asset(R.images.icon)

## resources/language

- this is where you keep your localization file
