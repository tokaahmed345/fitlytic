
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/controller/search_cubit/cubit/search_result_cubit.dart';
import 'package:flutter_application_depi/view/screen/Home/exercises/exercises_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SearchResultBody extends StatelessWidget {
  final String query;
  const SearchResultBody({
    super.key,
    required this.query,
  });
  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Type something to search...'));
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchResultCubit>().search(query);
    });
    return BlocBuilder<SearchResultCubit, SearchResultState>(
      builder: (context, state) {
        if (state is SerachLoading) {
          return const  Center(child: SpinKitSpinningLines(
             color: Colors.blue,
              size: 50.0,
          ));
        } else if (state is SearchSuccess) {
          if (state.searchReasult.isEmpty) {
            return const Center(child: Text('No results found.'));
          }

          return ListView.builder(
            itemCount: state.searchReasult.length,
            itemBuilder: (context, index) {
              final exercise = state.searchReasult[index];
              return ListTile(
                title: Text(exercise.name!),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ExerciseDetailsScreen(excersice: exercise),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is SearchFailure) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        } else {
          return const Center(child: Text('Type to search...'));
        }
      },
    );
  }
}
