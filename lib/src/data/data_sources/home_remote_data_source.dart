import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class HomeRemoteDataSource {
  Future<Response> getIpInfo();

  Future<Response> getRemnawaveVless(String link);
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;

  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<Response<dynamic>> getIpInfo() async {
    return await _dio.get('https://ipinfo.io/json');
  }

  @override
  Future<Response<dynamic>> getRemnawaveVless(String link) async {
    return await _dio.get(
      link,
      options: Options(responseType: ResponseType.plain),
    );
  }
}
