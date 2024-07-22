part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class PopularMovieSuccess extends HomeState {}

final class PopularMovieLoading extends HomeState {}
final class PopularMovieError extends HomeState {}

final class NewReleaseLoading extends HomeState {}

final class NewReleaseSuccess extends HomeState {}

final class NewReleaseError extends HomeState {}

final class RecommendMovieLoading extends HomeState {}

final class RecommendMovieSuccess extends HomeState {}

final class RecommendMovieError extends HomeState {}
