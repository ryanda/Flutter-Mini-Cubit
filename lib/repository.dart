import 'package:mini/http.dart' as http;
import 'package:mini/obj.dart';

class Endpoints {
  static const String BASE_URL = "https://reqres.in/api/";
  static const String LIST_DATA = "unknown";
  static const String SINGLE_USERS = "users/2";
  static const String IS_DELAY = "?delay=3";

  Future<ObjHolder> listData() {
    return http.doNetwork(LIST_DATA + IS_DELAY, mode: http.GET_METHOD);
  }

  Future<ObjHolder> profile() {
    return http.doNetwork(SINGLE_USERS, mode: http.GET_METHOD);
  }
}
