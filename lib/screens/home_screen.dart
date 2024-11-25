import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../blocs/post_bloc.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';
import '../widgets/custome_appbar_widget.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  final TextEditingController postController = TextEditingController();
  final TextEditingController editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: "Home",
        onSignOut: _confirmSignOut,
      ),
      body: Container(
        color: AppColors.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BlocListener<PostBloc, PostState>(
                listener: (context, state) {
                  if (state is PostSuccess) {
                    _showSnackbar(context, state.message, Colors.green);
                  } else if (state is PostError) {
                    _showSnackbar(context, state.errorMessage, Colors.red);
                  }
                },
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PostLoaded) {
                      if (state.posts.isEmpty) {
                        return Center(
                          child: Text(
                            "No Posts Yet",
                            style: AppTextStyles.airbnbCerealText(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          final post = state.posts[index];
                          final postId = post['id'];
                          final timestamp = post['timestamp'] as DateTime?;
                          String formattedDate = timestamp != null
                              ? timeago.format(timestamp)
                              : "No timestamp";

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              elevation: 2,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              color: const Color.fromARGB(255, 58, 89, 120),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post['message'] ?? '',
                                      style: AppTextStyles.airbnbCerealText(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Divider(
                                      color: Color.fromARGB(255, 232, 213, 213),
                                      thickness: 1,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.person,
                                                size: 16, color: Colors.blue),
                                            const SizedBox(width: 4),
                                            Text(
                                              post['username'] ?? 'Anonymous',
                                              style: AppTextStyles
                                                  .airbnbCerealText(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            const Icon(Icons.access_time,
                                                size: 16, color: Colors.orange),
                                            const SizedBox(width: 4),
                                            Text(
                                              formattedDate,
                                              style: AppTextStyles
                                                  .airbnbCerealText(
                                                fontSize: 12,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              editController.text =
                                                  post['message'] ?? '';
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      "Edit Post",
                                                      style: AppTextStyles
                                                          .airbnbCerealText(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    content: TextField(
                                                      controller:
                                                          editController,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            "Edit your post",
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          context
                                                              .read<PostBloc>()
                                                              .add(
                                                                  UpdatePostEvent(
                                                                postId,
                                                                editController
                                                                    .text,
                                                              ));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("Save"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            tooltip: 'Edit Post',
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              _confirmDeletePost(postId);
                                            },
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            tooltip: 'Delete Post',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is PostError) {
                      return Center(child: Text(state.errorMessage));
                    }
                    return const Center(child: Text("No Posts Yet"));
                  },
                ),
              ),
            ),
            Container(
              height: 120,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 39, 64, 88),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: postController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Write a post...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        style: AppTextStyles.airbnbCerealText(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blueAccent,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          final text = postController.text.trim();
                          if (text.isNotEmpty) {
                            context.read<PostBloc>().add(AddPostEvent(text));
                            postController.clear();
                          } else {
                            _showSnackbar(
                                context, "Post cannot be empty", Colors.red);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign Out"),
          content: const Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeletePost(String postId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Post"),
          content: const Text("Are you sure you want to delete this post?"),
          actions: [
            TextButton(
              onPressed: () {
                context.read<PostBloc>().add(DeletePostEvent(postId));
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
