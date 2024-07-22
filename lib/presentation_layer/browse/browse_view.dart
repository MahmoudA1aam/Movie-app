import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/business_logic_layer/browse_bloc/browse_cubit.dart';
import 'package:movie/data_layer/repository/browse_repo/browse_repo.dart';
import 'package:movie/data_layer/services/browse_services/browse_services.dart';

import '../../data_layer/models/browse_model/browse_category_model.dart';
import 'browse_movies_view.dart';

class BrowseView extends StatefulWidget {
  const BrowseView({super.key});

  @override
  State<BrowseView> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocProvider<BrowseCubit>(
      create: (context) => BrowseCubit(
          browseRepository: BrowseRepository(browseServices: BrowseServices()))
        ..getBrowseCategory(),
      child: Padding(
        padding: EdgeInsets.only(
            left: mediaQuery.width * 0.04,
            right: mediaQuery.width * 0.04,
            top: 75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Browse Category",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<BrowseCubit, BrowseState>(
              builder: (context, state) {
                var cubit = BrowseCubit.get(context);
                if (state is BrowseLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 6,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: cubit.browseCategoryList!.length,
                    itemBuilder: (context, index) {
                      return CategoryItem(
                          listMoviesModel: cubit.browseCategoryList![index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.listMoviesModel});

  final Genres listMoviesModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BrowseFilmView(
              id: listMoviesModel.id ?? 0,
              title: listMoviesModel.name.toString(),
            );
          },
        ));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: const DecorationImage(
                image: AssetImage("assets/images/image category.png"))),
        child: Text(
          listMoviesModel.name.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
