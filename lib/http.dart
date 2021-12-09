import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:mini/obj.dart';
import 'package:mini/repository.dart';

const String GET_METHOD = 'GET';
const String POST_METHOD = 'POST';

var http = dio.Dio();

void networkInit() {
  var headers = {
    dio.Headers.acceptHeader: dio.Headers.jsonContentType,
  };
  var opt = dio.BaseOptions(
    baseUrl: Endpoints.BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: headers,
  );
  http = dio.Dio(opt);

  http.interceptors.add(dio.LogInterceptor(responseBody: false));
}

setTokenHeader(String tokenString) {
  http.options.headers["Authorization"] = 'Bearer $tokenString';
}

Future<ObjHolder> doNetwork(
  String link, {
  String mode = GET_METHOD,
  Map<String, dynamic> body = const {},
}) async {
  dio.Response response;
  Map<String, dynamic> emptyObject = {};
  ObjHolder res =
      ObjHolder(false, emptyObject, new BaseResponse(code: 0, message: ""));
  try {
    if (mode == GET_METHOD) {
      response = await http.get(link);
    } else {
      response = await http.post(link, data: dio.FormData.fromMap(body));
    }

    res.success = true;
    res.response = response.data;
  } on dio.DioError catch (e) {
    String messageErr = e.toString();

    var timeoutType = [
      dio.DioErrorType.sendTimeout,
      dio.DioErrorType.connectTimeout,
      dio.DioErrorType.receiveTimeout
    ];

    if (timeoutType.contains(e.type)) {
      messageErr = "Timeout Request";
    } else {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        ErrorResponse er = ErrorResponse.fromJson(e.response!.data);
        messageErr = er.message;
      } else {
        if (e.type != dio.DioErrorType.other) {
          messageErr = "Server Problem [" + e.toString() + "]";
        } else {
          String msg = e.error.message.toString();
          if (e.error is HttpException) {
            messageErr = "HTTP Issue [ " + e.type.toString() + " ]: " + msg;
          } else {
            print(e.error);
            messageErr = "Connection Problem: " + msg;
          }
        }
      }

      // Something happened in setting up or sending the request that triggered an Error
      print(e.message);
    }

    throw Exception(messageErr);
  } catch (e) {
    // unhandled exception
    res.errresponse.code = 0;
    if (e is SocketException) {
      res.errresponse.message = "Server unreachable";
    } else {
      res.errresponse.message = e.toString();
    }
  }

  return res;
}
