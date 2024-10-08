import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone_app/state/posts/notifiers/delete_post_state_notiier.dart';

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, IsLoading>(
  (_) => DeletePostStateNotifier(),
);
