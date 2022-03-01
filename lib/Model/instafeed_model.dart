import 'dart:convert';

InstaFeedModel instaFeedModelFromJson(String str) =>
    InstaFeedModel.fromJson(json.decode(str));

String instaFeedModelToJson(InstaFeedModel data) => json.encode(data.toJson());

class InstaFeedModel {
  InstaFeedModel({
    this.status,
    this.message,
    this.posts,
  });

  int? status;
  String? message;
  List<Post>? posts;

  factory InstaFeedModel.fromJson(Map<String, dynamic> json) => InstaFeedModel(
        status: json["status"],
        message: json["message"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    this.images,
    this.description,
    this.interactions,
    this.postedBy,
    this.profileImage,
  });

  List<String>? images;
  String? description;
  Interactions? interactions;
  String? postedBy;
  String? profileImage;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        images: List<String>.from(json["images"].map((x) => x)),
        description: json["description"],
        interactions: Interactions.fromJson(json["interactions"]),
        postedBy: json["postedBy"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images!.map((x) => x)),
        "description": description,
        "interactions": interactions!.toJson(),
        "postedBy": postedBy,
        "profileImage": profileImage,
      };
}

class Interactions {
  Interactions({
    this.likes,
    this.comments,
    this.bookmarked,
  });

  int? likes;
  int? comments;
  bool? bookmarked;

  factory Interactions.fromJson(Map<String, dynamic> json) => Interactions(
        likes: json["likes"],
        comments: json["comments"],
        bookmarked: json["bookmarked"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "comments": comments,
        "bookmarked": bookmarked,
      };
}
