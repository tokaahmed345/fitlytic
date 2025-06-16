
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/widget/searchwidget/search_result_body.dart';

class ExercisesSearch extends SearchDelegate {
  ExercisesSearch();

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultBody(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchResultBody(
      query: query,
    );
  }
}
