import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/form.dart';

class SheetAPI {
  // Google App Script Web URL
  static const String URL =
      "https://script.google.com/macros/s/AKfycbwXGefkERtzlHFL1_DZ_sT0quayYwIXKPYF_VGl7UgJrhZhmVTkYuBfqwWJzNGvkRSL/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  // Submit form data
  void submitForm(
    FeedbackForm feedbackForm,
    void Function(String) callback,
  ) async {
    try {
      await http.post(Uri.parse(URL), body: feedbackForm.toJson()).then((
        response,
      ) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          if (url != null) {
            await http.get(Uri.parse(url)).then((response) {
              callback(convert.jsonDecode(response.body)['status']);
            });
          } else {
            callback("ERROR: Redirect URL not found");
          }
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print("Error submitting form: $e");
      callback("ERROR");
    }
  }

  // Fetch feedback list
  Future<List<FeedbackForm>> getFeedbackList() async {
    try {
      final response = await http.get(Uri.parse(URL));
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching feedback list: $e");
      return [];
    }
  }
}
