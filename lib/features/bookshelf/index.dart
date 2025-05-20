import './export/index.dart';

class BookshelfScreen extends StatelessWidget {
  const BookshelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (_) => TabBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            elevation: 0,
            toolbarHeight: 100,
            backgroundColor: Colors.white,
            title: BlocBuilder<TabBloc, TabState>(
              builder: (context, state) {
                final selectedIndex =
                    state is TabChangeState ? state.selectedIndex : 0;
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 3,
                        spreadRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      buildTab(
                        context,
                        index: 0,
                        icon: Icons.menu_book_rounded,
                        label: 'Sedang Dibaca',
                        selected: selectedIndex == 0,
                      ),
                      buildTab(
                        context,
                        index: 1,
                        icon: Icons.book_rounded,
                        label: 'Riwayat',
                        selected: selectedIndex == 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: BlocBuilder<TabBloc, TabState>(
            builder: (context, state) {
              final selectedIndex =
                  state is TabChangeState ? state.selectedIndex : 0;
              switch (selectedIndex) {
                case 0:
                  return ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: CardItemRead(),
                      );
                    },
                  );
                case 1:
                  return ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: CardItemHistory(),
                      );
                    },
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
