import 'package:flutter/material.dart';
import 'package:instagram_clone_app/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_app/state/posts/typedefs/user_id.dart';

@immutable
class LikeDislikeRequest {
  final PostId postId;
  final UserId likedBy;

  const LikeDislikeRequest({
    required this.postId,
    required this.likedBy,
  });
}
