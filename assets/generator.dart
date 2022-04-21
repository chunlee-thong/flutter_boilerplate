import 'dart:io';

void main() {
  generateFile();
}

void generateFile() async {
  final Directory dir = Directory('./images');
  final File assetClassFile = File("../lib/src/constant/app_assets.dart");
  //
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
    assetClassFile.writeAsStringSync(buffer.toString());
  }
  assetClassFile.writeAsStringSync("\n}", mode: FileMode.append);
}

String generateImageAssetsClass(String path) {
  final String imageName = path.split("/").last.replaceAll("%20", " ");
  if (imageName.startsWith(".")) {
    return "";
  }
  final String imagePath = path.replaceAll("%20", " ");
  String imageFieldName = imageName.replaceAll(RegExp(r'[-_\s+\b|\b\s]'), " ").split(".").first;
  final List<String> words = imageFieldName.split(" ").map(_upperCaseFirstLetter).toList();
  if (words.isNotEmpty) {
    words[0] = words[0].toLowerCase();
  }
  imageFieldName = words.join("");
  return '\n  static const String $imageFieldName = "assets/$imagePath";';
}

String _upperCaseFirstLetter(String word) {
  if (word.isEmpty) return "";
  return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
}
