import 'package:flutter/material.dart';
import 'package:instafeed/Model/instafeed_model.dart';
import 'package:instafeed/Screens/home_page.dart';

class InstaPost extends StatelessWidget {
  InstaPost({required this.index, Key? key}) : super(key: key);
  final int index;

  ValueNotifier<int> page = ValueNotifier(0);
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    Post postData = InheritedFeedData.of(context)!.feedData.posts![index];

    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.loose(
              Size(double.infinity, MediaQuery.of(context).size.height * .7)),
          child: Center(
            child: AspectRatio(
              aspectRatio: 10 / 12,
              child: PageView.builder(
                controller: _controller,
                itemCount: postData.images!.length,
                onPageChanged: (p) => page.value = p,
                itemBuilder: (BuildContext context, int i) {
                  return Image.network(
                    postData.images![i],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${((loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!) * 100).ceil()} %'),
                            LinearProgressIndicator(
                              value: (loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!),
                            ),
                          ],
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            Text('There was an error loading this image'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        if (postData.images!.length > 1)
          ValueListenableBuilder(
            valueListenable: page,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  postData.images!.length,
                  (index) => GestureDetector(
                    onTap: () {
                      _controller.animateToPage(index,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    child: Container(
                      height: 15,
                      width: 15,
                      margin: EdgeInsets.all(5),
                      decoration: ShapeDecoration(
                        color: index == value ? Colors.white : Colors.grey[700],
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
