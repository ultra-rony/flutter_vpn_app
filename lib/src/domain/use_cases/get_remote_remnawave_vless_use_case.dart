import 'package:injectable/injectable.dart';
import 'package:vpnapp/core/network/network_result.dart';
import 'package:vpnapp/core/use_cases/use_case.dart';
import 'package:vpnapp/src/domain/repositories/home_repository.dart';

@injectable
class GetRemoteRemnawaveVlessUseCase
    implements UseCase<Result<List<String>?>, String?> {
  final HomeRepository _repository;

  GetRemoteRemnawaveVlessUseCase(this._repository);

  @override
  Future<Result<List<String>?>> call({String? params}) async {
    return await _repository.getRemnawaveVless(params ?? "");
  }
}
