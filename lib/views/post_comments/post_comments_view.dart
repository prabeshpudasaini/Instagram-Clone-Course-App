import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_app/state/comments/models/post_comments_request.dart';
import 'package:instagram_clone_app/state/comments/providers/post_comments_provider.dart';
import 'package:instagram_clone_app/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone_app/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_app/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone_app/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_app/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_app/views/components/comment/comment_tile.dart';
import 'package:instagram_clone_app/views/constants/strings.dart';
import 'package:instagram_clone_app/views/extensions/dismiss_keyboard.dart';

class PostCommentsView extends HookConsumerWidget {
  final PostId postId;

  const PostCommentsView({
    super.key,
    required this.postId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();

    final hasText = useState(false);

    final request = useState(
      RequestForPostAndComments(postId: postId),
    );

    final comments = ref.watch(postCommentProvider(request.value));

    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          Strings.comments,
        ),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(
                      commentController,
                      ref,
                    );
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentsWithTextAnimationView(
                        text: Strings.noCommentsYet,
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () {
                      // ref.refresh(
                      //   postCommentProvider(request.value),
                      // );
                      ref.invalidate(
                        postCommentProvider(request.value),
                      );
                      return Future.delayed(
                        const Duration(
                          seconds: 1,
                        ),
                      );
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments.elementAt(index);
                        return CommentTile(comment: comment);
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const ErrorAnimationView();
                },
                loading: () {
                  return const LoadingAnimationView();
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextField(
                      textInputAction: TextInputAction.send,
                      controller: commentController,
                      onSubmitted: (comment) {
                        if (comment.isNotEmpty) {
                          _submitCommentWithController(
                            commentController,
                            ref,
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Strings.writeYourCommentHere,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final comment = controller.text;
    final isSent = await ref
        .read(
          sendCommentProvider.notifier,
        )
        .sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: comment,
        );
    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
