import 'package:vpnapp/core/network/network_result.dart';
import 'package:vpnapp/src/domain/entities/ipinfo_entity.dart';

abstract class HomeRepository {
  Future<Result<IpinfoEntity?>> getIpInfo();

  Future<Result<List<String>?>> getRemnawaveVless(String link);
}
