
import 'dart:convert';

ResponseModel registerResponseModelJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

class ResponseModel {
  ResponseModel({
    required this.status,
    this.msg,
  });
  late final int status;
  late final String? msg;

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    return data;
  }
}