import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instafeed/Model/instafeed_model.dart';
import 'package:instafeed/Screens/splash_screen.dart';
import 'package:instafeed/Widgets/insta_description.dart';
import 'package:instafeed/Widgets/insta_post.dart';
import 'package:instafeed/Widgets/insta_user.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  ScrollController _scrollController = ScrollController();
  late List<GlobalKey<State>> keys;
  bool inited = false;
  ScrollDirection currdir = ScrollDirection.idle;
  int item = 0;
  UserScrollNotification? user;
  ValueNotifier<bool> disableSnapping = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as InstaFeedModel;
    if (!inited) {
      keys = List.generate(
          args.posts!.length, (index) => GlobalKey(debugLabel: 'key\$$index'));
    }

    return InheritedFeedData(
      feedData: args,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'InstaFeed',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            actions: [
              ValueListenableBuilder<bool>(
                  valueListenable: disableSnapping,
                  builder: (context, val, child) {
                    return Switch(
                        value: val,
                        onChanged: (value) {
                          disableSnapping.value = !disableSnapping.value;
                        });
                  })
            ],
          ),
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (disableSnapping.value) {
                // if (notification.direction != ScrollDirection.idle) {
                currdir = notification.direction;
                // } else {
                if (currdir == ScrollDirection.reverse) {
                  if (item >= args.posts!.length - 1) {
                  } else {
                    item++;
                  }
                } else if (currdir == ScrollDirection.forward) {
                  if (item <= 0) {
                  } else {
                    item--;
                  }
                }
                Scrollable.ensureVisible(
                  keys[(item)].currentContext!,
                  duration: Duration(milliseconds: 100),
                );
                // }
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: List.generate(
                  args.posts!.length,
                  (index) => Column(
                    key: keys[index],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InstaUser(index: index),
                      InstaPost(index: index),
                      InstaDescription(index: index),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InheritedFeedData extends InheritedWidget {
  InheritedFeedData({Key? key, required this.feedData, required this.child})
      : super(key: key, child: child);

  final Widget child;
  final InstaFeedModel feedData;

  static InheritedFeedData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedFeedData>();
  }

  @override
  bool updateShouldNotify(InheritedFeedData oldWidget) {
    return true;
  }
}
