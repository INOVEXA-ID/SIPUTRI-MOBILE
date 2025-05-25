part of 'ulasan_global_bloc.dart';

sealed class UlasanGlobalEvent {}

class GetUlasanGlobalEvent extends UlasanGlobalEvent {
  final String bukuId;

  GetUlasanGlobalEvent({required this.bukuId});
}
