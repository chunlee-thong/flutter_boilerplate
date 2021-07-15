import 'dart:io';

File resourceClass = File("../lib/src/constant/app_assets.dart");

void main() {
  generateFile();
}

void generateFile() async {
  Directory dir = Directory('./images');
  var buffer = StringBuffer();
  buffer.writeln("//this class is generated from assets/generator.dart");
  buffer.write("class AppAssets {");
  List<FileSystemEntity> filesSystem = dir.listSync(recursive: true);

  for (final fileSystem in filesSystem) {
    if (fileSystem is Directory) {
      continue;
    } else {
      buffer.write(generateImageAssetsClass(fileSystem.uri.path));
    }
    await resourceClass.writeAsString(buffer.toString());
  }
  resourceClass.writeAsStringSync("\n}", mode: FileMode.append);
  print("Success");
}

String generateImageAssetsClass(String path) {
  final String imageName = path.split("/").last.replaceAll("%20", " ");
  final String imageFieldName = imageName.replaceAll(RegExp(r'[-\s+\b|\b\s]'), "_").split(".").first.toUpperCase();
  return '\n  static const String $imageFieldName = "$path";';
}
