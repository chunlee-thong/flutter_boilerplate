import 'dart:io';

File resourceClass = File("../lib/constant/app_assets.dart");
String classData = "class AppAssets {";

void main() {
  generateFile();
}

void generateFile() async {
  Directory dir = Directory('./images');
  List<FileSystemEntity> fileList = dir.listSync(recursive: true);

  for (int i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    classData += generateImageAssetsClass(file.uri.path);
    await resourceClass.writeAsString(classData);
  }
  resourceClass.writeAsStringSync("\n}", mode: FileMode.append);
}

String generateImageAssetsClass(String path) {
  final String imageName = path.split("/").last.replaceAll("%20", " ");
  final String imageFieldName = imageName
      .replaceAll(RegExp(r'[-\s+\b|\b\s]'), "_")
      .split(".")
      .first
      .toUpperCase();
  return '\n  static const String $imageFieldName = "assets/images/$imageName";';
}
