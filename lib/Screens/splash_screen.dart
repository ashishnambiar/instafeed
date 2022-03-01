import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instafeed/Controller/instafeed_controller.dart';
import 'package:instafeed/Model/instafeed_model.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  InstaFeedController _feed = InstaFeedController();

  @override
  Widget build(BuildContext context) {
    _feed.getData();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _feed.isLoaded.addListener(() {
        Navigator.pushReplacementNamed(context, '/Home', arguments: _feed.data);
      });
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'InstaFeed',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Container(
                width: MediaQuery.of(context).size.width * .5,
                child: LinearProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
