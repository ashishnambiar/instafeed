import 'package:http/http.dart';
import 'package:instafeed/Model/instafeed_model.dart';
import 'package:instafeed/constants.dart';

class InstaFeedServices {
  Client client = Client();

  Future<InstaFeedModel> fetchFeed() async {
    Response res = await client.get(Uri.parse(Feedurl));
    return instaFeedModelFromJson(res.body);
  }
}
