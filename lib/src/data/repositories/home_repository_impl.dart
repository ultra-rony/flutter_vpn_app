import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vpnapp/core/network/network_result.dart';
import 'package:vpnapp/src/data/data_sources/home_remote_data_source.dart';
import 'package:vpnapp/src/data/mappers/ipinfo_mapper.dart';
import 'package:vpnapp/src/data/models/ipinfo_model.dart';
import 'package:vpnapp/src/domain/entities/ipinfo_entity.dart';
import 'package:vpnapp/src/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(this._homeRemoteDataSource);

  @override
  Future<Result<IpinfoEntity?>> getIpInfo() async {
    try {
      final httpResponse = await _homeRemoteDataSource.getIpInfo();
      if (httpResponse.statusCode == 200) {
        final model = IpinfoModel.fromJson(httpResponse.data);
        return Success(model.toEntity());
      }
      return Failure('Status code: ${httpResponse.statusCode}');
    } on DioException catch (e) {
      return Failure('Error: $e');
    }
  }

  @override
  Future<Result<List<String>?>> getRemnawaveVless(String link) async {
    try {
      final response = await _homeRemoteDataSource.getRemnawaveVless(link);
      if (response.statusCode == 200) {
        final decoded = utf8.decode(base64.decode(response.data));
        final list = decoded
            .split('\n')
            .where((e) => e.trim().isNotEmpty)
            .where((e) => e.startsWith('vless://'))
            .toList();
        return Success(list);
      }
      return Failure('Status code: ${response.statusCode}');
    } on DioException catch (e) {
      return Failure('Dio error: ${e.message}');
    } catch (e) {
      return Failure('Decode error: $e');
    }
  }
}
