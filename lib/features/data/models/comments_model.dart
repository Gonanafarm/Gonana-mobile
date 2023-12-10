// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) =>
    CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  bool? success;
  List<Comment>? comments;

  CommentsModel({
    this.success,
    this.comments,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        success: json["success"],
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  String? username;
  String? comment;
  String? image;

  Comment({
    this.username,
    this.comment,
    this.image,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        username: json["username"],
        comment: json["comment"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "comment": comment,
        "image": image,
      };
}
