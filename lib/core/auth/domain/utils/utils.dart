import 'dart:convert';

import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';

class Utils {
  static JSON decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }
    final payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    final Map<String, dynamic> payloadMap = json.decode(resp);
    return payloadMap;
  }
}
