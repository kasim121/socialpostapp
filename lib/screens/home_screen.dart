import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/post_bloc.dart';

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
      appBar: AppBar(
        title: Text(
          "Home",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              _confirmSignOut();
            },
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                          return const Center(
                            child: Text(
                              "No Posts Yet",
                              style: TextStyle(fontSize: 18),
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

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Post Message
                                    Text(
                                      post['message'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                        height:
                                            1.5, // Improved readability for paragraphs
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Divider
                                    Divider(
                                        color: Colors.grey.shade300,
                                        thickness: 1),
                                    const SizedBox(height: 8),
                                    // Metadata (Username and Timestamp)
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.person,
                                                size: 16, color: Colors.blue),
                                            const SizedBox(width: 4),
                                            Text(
                                              post['username'] ?? 'Anonymous',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade700,
                                                fontStyle: FontStyle.italic,
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
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    // Action Buttons (Aligned Bottom-Right)
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
                                                    title:
                                                        const Text("Edit Post"),
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
                                                              .add(UpdatePostEvent(
                                                                  postId,
                                                                  editController
                                                                      .text));
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
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
            ],
          ),
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
