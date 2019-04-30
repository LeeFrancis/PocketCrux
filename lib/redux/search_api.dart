import 'package:http/http.dart' as http;

class SearchApi {
  //String url = 'https://swapi.co/api/people/1';
  String url =
      'http://ebsconext-edge.eksk-useast1.eks.eis-deliverydevqa.cloud/search?count=10&';
  String query;

  SearchApi(this.query);

  Future<String> fetchResults() async {
    print(this.query);
    final response = await http.get('${url}q=${this.query}');
    return response.body;
  }
}
