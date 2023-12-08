import 'dart:convert';

class DataTableEncode{
  static String encodeToBase64(String data) {
    List<int> bytes = utf8.encode(data);
    String base64String = base64Encode(bytes);
    return base64String;
  }

  static String decodeFromBase64(String base64String) {
    List<int> bytes = base64Decode(base64String);
    String decodedData = utf8.decode(bytes);
    return decodedData;
  }
}