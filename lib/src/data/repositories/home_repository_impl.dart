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
}
