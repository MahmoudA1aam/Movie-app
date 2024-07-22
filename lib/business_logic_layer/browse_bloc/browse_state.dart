part of 'browse_cubit.dart';

@immutable
sealed class BrowseState {}

final class BrowseInitial extends BrowseState {}

final class BrowseLoading extends BrowseState {}

final class BrowseSuccess extends BrowseState {}

final class BrowseError extends BrowseState {}

