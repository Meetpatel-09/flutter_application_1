import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/responce.dart';

class APIServices {
  static Future<ResponseModel> uploadFile(FormData data) async {

    var responce = await Dio().post(
      "http://192.168.1.3/php-api/file-uploade.php",
      data: data,
    );

    return ResponseModel(
        status: responce.statusCode!, msg: responce.statusMessage);
  }
}
