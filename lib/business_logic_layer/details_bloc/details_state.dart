part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class DetailsSuccess extends DetailsState {}

final class DetailsError extends DetailsState {}

final class MoreLikeLoading extends DetailsState {}

final class MoreLikeSuccess extends DetailsState {}

final class MoreLikeError extends DetailsState {}
