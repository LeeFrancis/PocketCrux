import './result.dart';

class Search {
  int totalHits;
  ResultSuggestions resultSuggestions;
  List<Result> results;

  Search({this.totalHits, this.resultSuggestions, this.results});

  factory Search.fromJson(Map<String, dynamic> parsedJson) {
    parsedJson = parsedJson ?? {};
    return Search(
        totalHits: parsedJson['totalHits'],
        resultSuggestions:
            ResultSuggestions.fromJson(parsedJson['resultSuggestions']),
        results: (parsedJson['results'] ?? [])
            .map<Result>((result) => Result.fromJson(result))
            .toList());
  }

  Map toJson() => {
        'totalHits': totalHits,
        'resultSuggestions': resultSuggestions.toJson(),
        'results': results.map((result) => result.toJson()),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class ResultSuggestions {
  List<dynamic> didYouMean;
  ResultSuggestions({this.didYouMean});

  factory ResultSuggestions.fromJson(Map<String, dynamic> parsedJson) {
    parsedJson = parsedJson ?? {};
    return ResultSuggestions(didYouMean: parsedJson['didYouMean']);
  }
  Map toJson() => {
        'didYouMean': didYouMean,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
