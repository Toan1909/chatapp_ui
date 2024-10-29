
import 'package:dio/dio.dart';

import '../shared/spref.dart';

class AppService {
  static final BaseOptions _options = BaseOptions(
      baseUrl: 'http://localhost:3000',
      //baseUrl: 'http://192.168.110.67:3000',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000));
  static final Dio _dio = Dio(_options);
  AppService._internal() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions reqOpt, RequestInterceptorHandler handler) async {
      var token = await SPref.instance.get("token");
      if (token != null) {
        print("------------------");
        print("Token : " + token);
        print("------------------");
        reqOpt.headers["Authorization"] = "Bearer " + token;
      }
      return handler.next(reqOpt);
    }));
  }
  static final AppService instance = AppService._internal();
  Dio get dio => _dio;
}
