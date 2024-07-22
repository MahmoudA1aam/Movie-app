part of 'browse_movie_cubit.dart';

@immutable
sealed class BrowseMovieState {}

final class BrowseMovieInitial extends BrowseMovieState {}

final class BrowseMovieLoading extends BrowseMovieState {}

final class BrowseMovieSuccess extends BrowseMovieState {}

final class BrowseMovieError extends BrowseMovieState {}
