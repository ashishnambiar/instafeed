import 'package:flutter/material.dart';
import 'package:instafeed/Model/instafeed_model.dart';
import 'package:instafeed/Screens/home_page.dart';

class InstaUser extends StatelessWidget {
  const InstaUser({required this.index, Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    Post postData = InheritedFeedData.of(context)!.feedData.posts![index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(shape: CircleBorder()),
            height: 50,
            width: 50,
            child: Image.network(
              postData.profileImage!,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Text(
            postData.postedBy!,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
