import 'dart:io';

File resourceClass = File("../lib/constant/app_assets.dart");
String classData = "class AppAssets {";

void main() {
  generateFile();
}

void generateFile() async {
  Directory dir = Directory('./images');
  List<FileSystemEntity> filesSystem = dir.listSync(recursive: true);

  for (final fileSystem in filesSystem) {
    if (fileSystem is Directory) {
      continue;
    } else {
      classData += generateImageAssetsClass(fileSystem.uri.path);
    }
    await resourceClass.writeAsString(classData);
  }
  resourceClass.writeAsStringSync("\n}", mode: FileMode.append);
}

String generateImageAssetsClass(String path) {
  final String imageName = path.split("/").last.replaceAll("%20", " ");
  final String imageFieldName = imageName.replaceAll(RegExp(r'[-\s+\b|\b\s]'), "_").split(".").first.toUpperCase();
  return '\n  static const String $imageFieldName = "$path";';
}
