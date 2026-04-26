import 'package:freezed_annotation/freezed_annotation.dart';

part 'ipinfo_entity.freezed.dart';

@freezed
abstract class IpinfoEntity with _$IpinfoEntity {
  const factory IpinfoEntity({
    String? ip,
    String? hostname,
    String? city,
    String? region,
    String? country,
    String? loc,
    String? org,
    String? postal,
    String? timezone,
    String? readme,
  }) = _IpinfoEntity;
}
