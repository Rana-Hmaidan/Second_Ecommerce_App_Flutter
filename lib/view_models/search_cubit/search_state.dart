part of 'search_cubit.dart';

@immutable
sealed class SearchState {
  const SearchState();
}

final class SearchInitial extends SearchState{}

final class SearchLoading extends SearchState{}

final class SearchLoaded extends SearchState{

  final List<SearchItemModel> popularsearchItems;
  final List<String> lastSerchItems;

  const SearchLoaded({
    required this.lastSerchItems,
    required this.popularsearchItems,
  });
}

final class SearchError extends SearchState{
  final String message;

  const SearchError({
    required this.message
  });
}