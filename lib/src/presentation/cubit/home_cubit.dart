import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

@LazySingleton()
class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(const HomeState.initial());

  void setServers(List<String> servers) {
    emit(HomeState.data(
      servers: servers,
      selectedServerIndex: 0,
      isConnecting: false,
    ));
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      final type = json['runtimeType'];

      if (type == 'data') {
        return HomeState.data(
          servers: (json['servers'] as List<dynamic>?)?.map((e) => e as String).toList(),
          selectedServerIndex: json['selectedServerIndex'] as int?,
          isConnecting: json['isConnecting'] as bool? ?? false,
        );
      }
      return const HomeState.initial();
    } catch (_) {
      return const HomeState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.when(
      initial: () => {'runtimeType': 'initial'},
      data: (servers, selectedServerIndex, isConnecting) => {
        'runtimeType': 'data',
        'servers': servers,
        'selectedServerIndex': selectedServerIndex,
        'isConnecting': isConnecting,
      },
    );
  }
}
