import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:task_app/home/models.dart';

class HomeRepository {
  final _homeResponseController = PublishSubject<HomeScreenResponse>();

  Stream<HomeScreenResponse> get homeResponseController =>
      _homeResponseController.stream;

  Future<HomeScreenResponse> homeApiMethod() async {
    String apiurl =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=489aeec502c74daab1c03e35b513e4b2";
    var response = await http.get(
      Uri.parse(apiurl),
    );
    HomeScreenResponse homeResponse =
        HomeScreenResponse.fromJson(json.decode(response.body.toString()));
    _homeResponseController.sink.add(homeResponse);
    return homeResponse;
  }

  dispose() {
    _homeResponseController.close();
  }
}
