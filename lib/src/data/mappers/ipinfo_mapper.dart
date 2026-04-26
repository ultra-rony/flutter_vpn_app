// ipinfo_mapper.dart

import 'package:vpnapp/src/data/models/ipinfo_model.dart';
import 'package:vpnapp/src/domain/entities/ipinfo_entity.dart';

extension IpinfoMapper on IpinfoModel {
  /// Конвертация из Модели (Data) в Сущность (Domain)
  IpinfoEntity toEntity() {
    return IpinfoEntity(
      ip: ip,
      hostname: hostname,
      city: city,
      region: region,
      country: country,
      loc: loc,
      org: org,
      postal: postal,
      timezone: timezone,
      readme: readme,
    );
  }
}

extension IpinfoEntityMapper on IpinfoEntity {
  IpinfoModel toModel() {
    return IpinfoModel(
      ip: ip,
      hostname: hostname,
      city: city,
      region: region,
      country: country,
      loc: loc,
      org: org,
      postal: postal,
      timezone: timezone,
      readme: readme,
    );
  }
}
