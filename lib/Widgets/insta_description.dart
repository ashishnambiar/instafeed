import 'package:flutter/material.dart';
import 'package:instafeed/Model/instafeed_model.dart';
import 'package:instafeed/Screens/home_page.dart';

class InstaDescription extends StatelessWidget {
  InstaDescription({required this.index, Key? key}) : super(key: key);
  final int index;
  ValueNotifier<bool> showFull = ValueNotifier(false);
  ValueNotifier<bool> bookMark = ValueNotifier(false);
  ValueNotifier<bool> liked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Post postData = InheritedFeedData.of(context)!.feedData.posts![index];
    bookMark.value = postData.interactions!.bookmarked!;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onTap: () {
            showFull.value = !showFull.value;
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.transparent,
            child: ValueListenableBuilder<bool>(
              valueListenable: showFull,
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ValueListenableBuilder<bool>(
                                valueListenable: liked,
                                builder: (context, like, child) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          liked.value = !liked.value;
                                        },
                                        child: Icon(like
                                            ? Icons.thumb_up
                                            : Icons.thumb_up_alt_outlined),
                                      ),
                                      Visibility(
                                          visible: value,
                                          child: Text(
                                              '${postData.interactions!.likes! + (like ? 1 : 0)}'))
                                    ],
                                  );
                                }),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Icon(Icons.comment),
                                Visibility(
                                    visible: value,
                                    child: Text(
                                        '${postData.interactions!.comments}'))
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            bookMark.value = !bookMark.value;
                          },
                          child: ValueListenableBuilder<bool>(
                            valueListenable: bookMark,
                            builder: (context, value, child) {
                              return Icon(value
                                  ? Icons.bookmark
                                  : Icons.bookmark_border);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      maxLines: value ? 100 : 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${postData.postedBy} ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${postData.description!}'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
