import 'package:injectable/injectable.dart';
import 'package:vpnapp/core/network/network_result.dart';
import 'package:vpnapp/core/use_cases/use_case.dart';
import 'package:vpnapp/src/domain/entities/ipinfo_entity.dart';
import 'package:vpnapp/src/domain/repositories/home_repository.dart';

@injectable
class GetRemoteIpinfoUseCase implements UseCase<Result<IpinfoEntity?>, void> {
  final HomeRepository _repository;

  GetRemoteIpinfoUseCase(this._repository);

  @override
  Future<Result<IpinfoEntity?>> call({void params}) async {
    return await _repository.getIpInfo();
  }
}
