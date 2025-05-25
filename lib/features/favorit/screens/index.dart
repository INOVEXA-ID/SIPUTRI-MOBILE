import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/features/favorit/bloc/favorit_bloc.dart';
import 'package:siputri_mobile/features/favorit/components/empty.dart';

import '../export/index.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        title: MyText(
          title: "Favorit",
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: BlocBuilder<FavoritBloc, FavoritState>(
        builder: (context, state) {
          if (state is FavoritLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoritFailed) {
            return Center(child: Text(state.message));
          } else if (state is FavoritLoaded) {
            if (state.favoritModel.data.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<FavoritBloc>().add(GetFavorit());
                    await Future.delayed(Duration(seconds: 1));
                  },
                  child: ListView.builder(
                    itemCount: state.favoritModel.data.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index) {
                      final favorit = state.favoritModel.data[index].buku;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CardItems(
                          idBuku: favorit.idBuku.toString(),
                          title: favorit.judul,
                          penulis: favorit.penulis,
                          rating: "4.5",
                          description: favorit.deskripsi,
                          image:
                              "${ApiConstants.baseUrlImage}/${favorit.thumbnail}",
                          jmlUlasan: 0,
                          jmlPembaca: 0,
                          namaPembaca: "Rhomaedi",
                          tersedia: 1,
                          jmlBuku: favorit.jumlahBuku,
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return FavoritEmpty();
            }
          } else {
            return Text("Terjadi Kesalahan");
          }
        },
      ),
    );
  }
}
