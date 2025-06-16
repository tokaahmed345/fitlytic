import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_depi/core/services/get_exercieses-servciese.dart';
import 'package:flutter_application_depi/model/exercise_model.dart';
import 'package:meta/meta.dart';

part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit(this.searchServices) : super(SearchResultInitial());



final SearchServices searchServices;
Future<void>search(String quary)async{

emit(SerachLoading());
try{
final results= await  searchServices.getExerciseByName(quary);
 emit(SearchSuccess(results));
}catch(e){
emit(SearchFailure(errorMessage: e.toString()));


}


}



}
