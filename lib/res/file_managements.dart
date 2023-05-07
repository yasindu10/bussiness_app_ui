import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pickFile(List<String> extentions) async {
  final data = await FilePicker.platform.pickFiles(
    allowedExtensions: extentions,
    type: FileType.custom,
    allowMultiple: false,
  );

  if (data == null) {
    return null;
  } else {
    return data;
  }
}
