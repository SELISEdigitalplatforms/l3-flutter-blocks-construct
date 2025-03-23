import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UtilsUsecase {
  static Future<String> convertToBase64(XFile? xFile) async {
    if (xFile != null) {
      final File file = File(xFile.path);
      final bytes = await file.readAsBytes();
      String base64Image = base64Encode(bytes);
      String extension = xFile.path.split('.').last.toLowerCase();

      String mimeType;
      switch (extension) {
        case 'jpg':
        case 'jpeg':
          mimeType = 'image/jpeg';
          break;
        case 'png':
          mimeType = 'image/png';
          break;
        case 'gif':
          mimeType = 'image/gif';
          break;
        default:
          mimeType = 'image/jpeg';
      }
      return 'data:$mimeType;base64,$base64Image';
    }
    return '';
  }
}
