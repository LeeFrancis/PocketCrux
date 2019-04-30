import './search.dart';
import 'package:flutter/services.dart' show rootBundle;

class Results {
  final Search search;

  Results({this.search});

  factory Results.fromJson(Map<String, dynamic> parsedJson) {
    parsedJson = parsedJson ?? {};
    return Results(
      search: Search.fromJson(parsedJson['search']),
    );
  }
  Results copyWith({Results results}) {
    Search search = results.search ?? Search();
    return Results(
        search: Search(
            totalHits: search.totalHits,
            resultSuggestions: search.resultSuggestions,
            results: search.results));
  }

  Map toJson() => {
        'search': search?.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

getMockResult() async {
  return await rootBundle.loadString('assets/results.json');
}
