import 'dart:io';

File resourceClass = File("../lib/constant/resource_path.dart");
String classData = "class R{\n static Images images = Images();\n}\nclass Images {";

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
  final String imageName = path.split("/").last;
  final String imageFieldName = imageName.replaceAll("-", "").split(".").first.toUpperCase();
  return '\nString $imageFieldName = "$imageName";\n';
}
