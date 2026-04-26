import 'package:json_annotation/json_annotation.dart';

part 'ipinfo_model.g.dart';

@JsonSerializable()
class IpinfoModel {
  @JsonKey(name: "ip")
  final String? ip;
  @JsonKey(name: "hostname")
  final String? hostname;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "region")
  final String? region;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "loc")
  final String? loc;
  @JsonKey(name: "org")
  final String? org;
  @JsonKey(name: "postal")
  final String? postal;
  @JsonKey(name: "timezone")
  final String? timezone;
  @JsonKey(name: "readme")
  final String? readme;

  IpinfoModel({
    this.ip,
    this.hostname,
    this.city,
    this.region,
    this.country,
    this.loc,
    this.org,
    this.postal,
    this.timezone,
    this.readme,
  });

  factory IpinfoModel.fromJson(Map<String, dynamic> json) {
    return _$IpinfoModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IpinfoModelToJson(this);
  }
}
