part of 'search_result_cubit.dart';

@immutable
sealed class SearchResultState extends Equatable{


}
final class SearchResultInitial extends SearchResultState {
  @override
  List<Object?> get props => [];
}
final class SearchSuccess extends SearchResultState {
 final  List<ExcersiceModel>searchReasult;
  SearchSuccess(this.searchReasult);
  
  @override
  List<Object?> get props => [searchReasult];
}
final class SearchFailure extends SearchResultState {
  final String errorMessage;
  SearchFailure({required this.errorMessage});
  
  @override
  List<Object?> get props =>[errorMessage];
}
final class SerachLoading extends SearchResultState {
  @override
  List<Object?> get props => [];
}
