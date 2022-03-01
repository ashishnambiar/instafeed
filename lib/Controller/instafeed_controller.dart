import 'package:flutter/foundation.dart';
import 'package:instafeed/Model/instafeed_model.dart';
import 'package:instafeed/Services/instafeed_services.dart';

class InstaFeedController {
  InstaFeedModel data = InstaFeedModel();
  InstaFeedServices _service = InstaFeedServices();
  ValueNotifier<bool> isLoaded = ValueNotifier(false);

  getData() async {
    data = await _service.fetchFeed();
    isLoaded.value = true;
  }
}
