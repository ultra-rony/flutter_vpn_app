part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;

  const factory HomeState.data({
    List<String>? servers,
    int? selectedServerIndex,
    required bool isConnecting,
  }) = _Data;
}
