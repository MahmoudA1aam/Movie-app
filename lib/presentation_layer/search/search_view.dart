import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation_layer/search/widgets/movie_item.dart';


import '../../business_logic_layer/search_bloc/search_cubit.dart';
import '../../data_layer/models/home_model/new_release_model.dart';
import '../../data_layer/repository/search_repo/search_repo.dart';
import '../../data_layer/services/search_services/search_services.dart';

class SearchView extends StatefulWidget {
  SearchView({super.key});

  static String routeName = "history";
  bool isSearching = false;
  bool focus = true;
  TextEditingController searchController = TextEditingController();

  @override
  State<SearchView> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<SearchView> {
  late List<ResultsNewReleases>? searchedMovieList;
  late List<ResultsNewReleases>? allMovieList;
  String textfieldValue = "";

  late SearchCubit searchCubit;

  @override
  void initState() {
    // TODO: implement initState
    searchCubit = SearchCubit(
        searchRepository: SearchRepository(searchServices: SearchServices()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;

    return BlocProvider<SearchCubit>(
      create: (context) => searchCubit,
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          if (cubit.searchedMovieList.isEmpty) {
            return Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: mediaQuery.height * 0.08,
                  child: TextField(
                    controller: widget.searchController,
                    onTap: () {
                      widget.focus = true;
                      setState(() {});
                    },
                    canRequestFocus: widget.focus,
                    onSubmitted: (value) {
                      textfieldValue = value;

                      searchCubit.getSearch(query: textfieldValue);
                    },
                    cursorColor: Colors.grey,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    decoration: InputDecoration(
                        fillColor: const Color(0xff514F4F),
                        filled: true,
                        suffix: IconButton(
                            onPressed: () {
                              searchCubit.getSearch(query: textfieldValue);
                              cubit.searchMovieList;
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30,
                            )),
                        prefix: IconButton(
                            onPressed: () {
                              stopSearching();
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 30,
                            )),
                        hintText: "search",
                        hintStyle: const TextStyle(
                            color: Color(0xffB5B4B4), fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(25)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(25))),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Icon material-local-movies.png",
                        fit: BoxFit.cover,
                      ),
                      const Text(
                        "No movies found",
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                )
              ],
            );
          }

          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 55,
                    child: TextField(
                      controller: widget.searchController,
                      onTap: () {
                        widget.focus = true;
                        setState(() {});
                      },
                      canRequestFocus: widget.focus,
                      onSubmitted: (value) {
                        textfieldValue = value;

                        searchCubit.getSearch(query: textfieldValue);
                      },
                      cursorColor: Colors.grey,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                          fillColor: const Color(0xff514F4F),
                          filled: true,
                          suffix: IconButton(
                              onPressed: () {
                                searchCubit.getSearch(query: textfieldValue);
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              )),
                          prefix: IconButton(
                              onPressed: () {
                                stopSearching();
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 30,
                              )),
                          hintText: "search",
                          hintStyle: const TextStyle(
                              color: Color(0xffB5B4B4), fontSize: 20),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(25)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                  state is SearchLoading
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 50),
                            itemCount: widget.searchController.text.isEmpty
                                ? cubit.searchedMovieList!.length
                                : cubit.searchedMovieList!.length,
                            itemBuilder: (context, index) {
                              return MovieItem(
                                  model: widget.searchController.text.isEmpty
                                      ? cubit.searchedMovieList![index]
                                      : cubit.searchedMovieList![index]);
                            },
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void startSearch(BuildContext context) {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      widget.isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      widget.isSearching = false;
      widget.focus = false;
    });
  }

  void clearSearch() {
    setState(() {
      widget.searchController.clear();
    });
  }

  void addSearchedItemList(String value) {
    searchedMovieList = allMovieList!
        .where((e) => e.title!.toLowerCase().startsWith(value))
        .toList();
    setState(() {});
  }
}
