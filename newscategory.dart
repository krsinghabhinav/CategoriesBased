import 'package:furnitureapp/model/newsCategoryModel.dart';
import '../servicenetwork.dart/apiservice.dart';

class NewscategoryRepo {
  final ServiceNetwork serviceNetwork = ServiceNetwork();

  Future<newModelca?> getNewsRepo(String category) async {
    // URL formatted with the category parameter
    final String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=146ed57e382f4936965c15614315fc10';

    try {
      // Fetching the response using the serviceNetwork
      dynamic response = await serviceNetwork.getApifetch(url: url);

      // If the response is valid and contains 'articles', map it to model
      return newModelca.fromJson(response);
    } catch (e) {
      // Handle any errors that might occur during the API call
      print('Error fetching data: $e');
      return null; // Return null in case of error
    }
  }
}
