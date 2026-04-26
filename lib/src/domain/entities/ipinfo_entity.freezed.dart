// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ipinfo_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IpinfoEntity {

 String? get ip; String? get hostname; String? get city; String? get region; String? get country; String? get loc; String? get org; String? get postal; String? get timezone; String? get readme;
/// Create a copy of IpinfoEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IpinfoEntityCopyWith<IpinfoEntity> get copyWith => _$IpinfoEntityCopyWithImpl<IpinfoEntity>(this as IpinfoEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IpinfoEntity&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.city, city) || other.city == city)&&(identical(other.region, region) || other.region == region)&&(identical(other.country, country) || other.country == country)&&(identical(other.loc, loc) || other.loc == loc)&&(identical(other.org, org) || other.org == org)&&(identical(other.postal, postal) || other.postal == postal)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.readme, readme) || other.readme == readme));
}


@override
int get hashCode => Object.hash(runtimeType,ip,hostname,city,region,country,loc,org,postal,timezone,readme);

@override
String toString() {
  return 'IpinfoEntity(ip: $ip, hostname: $hostname, city: $city, region: $region, country: $country, loc: $loc, org: $org, postal: $postal, timezone: $timezone, readme: $readme)';
}


}

/// @nodoc
abstract mixin class $IpinfoEntityCopyWith<$Res>  {
  factory $IpinfoEntityCopyWith(IpinfoEntity value, $Res Function(IpinfoEntity) _then) = _$IpinfoEntityCopyWithImpl;
@useResult
$Res call({
 String? ip, String? hostname, String? city, String? region, String? country, String? loc, String? org, String? postal, String? timezone, String? readme
});




}
/// @nodoc
class _$IpinfoEntityCopyWithImpl<$Res>
    implements $IpinfoEntityCopyWith<$Res> {
  _$IpinfoEntityCopyWithImpl(this._self, this._then);

  final IpinfoEntity _self;
  final $Res Function(IpinfoEntity) _then;

/// Create a copy of IpinfoEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ip = freezed,Object? hostname = freezed,Object? city = freezed,Object? region = freezed,Object? country = freezed,Object? loc = freezed,Object? org = freezed,Object? postal = freezed,Object? timezone = freezed,Object? readme = freezed,}) {
  return _then(_self.copyWith(
ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,hostname: freezed == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,loc: freezed == loc ? _self.loc : loc // ignore: cast_nullable_to_non_nullable
as String?,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,postal: freezed == postal ? _self.postal : postal // ignore: cast_nullable_to_non_nullable
as String?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,readme: freezed == readme ? _self.readme : readme // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IpinfoEntity].
extension IpinfoEntityPatterns on IpinfoEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IpinfoEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IpinfoEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IpinfoEntity value)  $default,){
final _that = this;
switch (_that) {
case _IpinfoEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IpinfoEntity value)?  $default,){
final _that = this;
switch (_that) {
case _IpinfoEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? ip,  String? hostname,  String? city,  String? region,  String? country,  String? loc,  String? org,  String? postal,  String? timezone,  String? readme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IpinfoEntity() when $default != null:
return $default(_that.ip,_that.hostname,_that.city,_that.region,_that.country,_that.loc,_that.org,_that.postal,_that.timezone,_that.readme);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? ip,  String? hostname,  String? city,  String? region,  String? country,  String? loc,  String? org,  String? postal,  String? timezone,  String? readme)  $default,) {final _that = this;
switch (_that) {
case _IpinfoEntity():
return $default(_that.ip,_that.hostname,_that.city,_that.region,_that.country,_that.loc,_that.org,_that.postal,_that.timezone,_that.readme);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? ip,  String? hostname,  String? city,  String? region,  String? country,  String? loc,  String? org,  String? postal,  String? timezone,  String? readme)?  $default,) {final _that = this;
switch (_that) {
case _IpinfoEntity() when $default != null:
return $default(_that.ip,_that.hostname,_that.city,_that.region,_that.country,_that.loc,_that.org,_that.postal,_that.timezone,_that.readme);case _:
  return null;

}
}

}

/// @nodoc


class _IpinfoEntity implements IpinfoEntity {
  const _IpinfoEntity({this.ip, this.hostname, this.city, this.region, this.country, this.loc, this.org, this.postal, this.timezone, this.readme});
  

@override final  String? ip;
@override final  String? hostname;
@override final  String? city;
@override final  String? region;
@override final  String? country;
@override final  String? loc;
@override final  String? org;
@override final  String? postal;
@override final  String? timezone;
@override final  String? readme;

/// Create a copy of IpinfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IpinfoEntityCopyWith<_IpinfoEntity> get copyWith => __$IpinfoEntityCopyWithImpl<_IpinfoEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IpinfoEntity&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.city, city) || other.city == city)&&(identical(other.region, region) || other.region == region)&&(identical(other.country, country) || other.country == country)&&(identical(other.loc, loc) || other.loc == loc)&&(identical(other.org, org) || other.org == org)&&(identical(other.postal, postal) || other.postal == postal)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.readme, readme) || other.readme == readme));
}


@override
int get hashCode => Object.hash(runtimeType,ip,hostname,city,region,country,loc,org,postal,timezone,readme);

@override
String toString() {
  return 'IpinfoEntity(ip: $ip, hostname: $hostname, city: $city, region: $region, country: $country, loc: $loc, org: $org, postal: $postal, timezone: $timezone, readme: $readme)';
}


}

/// @nodoc
abstract mixin class _$IpinfoEntityCopyWith<$Res> implements $IpinfoEntityCopyWith<$Res> {
  factory _$IpinfoEntityCopyWith(_IpinfoEntity value, $Res Function(_IpinfoEntity) _then) = __$IpinfoEntityCopyWithImpl;
@override @useResult
$Res call({
 String? ip, String? hostname, String? city, String? region, String? country, String? loc, String? org, String? postal, String? timezone, String? readme
});




}
/// @nodoc
class __$IpinfoEntityCopyWithImpl<$Res>
    implements _$IpinfoEntityCopyWith<$Res> {
  __$IpinfoEntityCopyWithImpl(this._self, this._then);

  final _IpinfoEntity _self;
  final $Res Function(_IpinfoEntity) _then;

/// Create a copy of IpinfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ip = freezed,Object? hostname = freezed,Object? city = freezed,Object? region = freezed,Object? country = freezed,Object? loc = freezed,Object? org = freezed,Object? postal = freezed,Object? timezone = freezed,Object? readme = freezed,}) {
  return _then(_IpinfoEntity(
ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,hostname: freezed == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,loc: freezed == loc ? _self.loc : loc // ignore: cast_nullable_to_non_nullable
as String?,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,postal: freezed == postal ? _self.postal : postal // ignore: cast_nullable_to_non_nullable
as String?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,readme: freezed == readme ? _self.readme : readme // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
