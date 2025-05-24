part of 'detail_buku_bloc.dart';

sealed class DetailBukuEvent {}

class GetDetailBuku extends DetailBukuEvent {
  final String id;
  GetDetailBuku({required this.id});
}
