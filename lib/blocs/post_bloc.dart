import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PostEvent {}

class AddPostEvent extends PostEvent {
  final String message;
  AddPostEvent(this.message);
}

class FetchPostsEvent extends PostEvent {}

class UpdatePostEvent extends PostEvent {
  final String postId;
  final String updatedMessage;
  UpdatePostEvent(this.postId, this.updatedMessage);
}

class DeletePostEvent extends PostEvent {
  final String postId;
  DeletePostEvent(this.postId);
}

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Map<String, dynamic>> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String errorMessage;
  PostError(this.errorMessage);
}

class PostSuccess extends PostState {
  final String message;
  PostSuccess(this.message);
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  PostBloc() : super(PostInitial()) {
    on<AddPostEvent>(_addPost);
    on<FetchPostsEvent>(_fetchPosts);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);
  }

  Future<void> _addPost(AddPostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      String username =
          (userDoc.data() as Map<String, dynamic>)['name'] ?? 'Anonymous';

      await _firestore.collection('posts').add({
        'message': event.message,
        'username': username,
        'timestamp': FieldValue.serverTimestamp(),
      });

      emit(PostSuccess('Post added successfully!'));
      add(FetchPostsEvent());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _fetchPosts(
      FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final querySnapshot = await _firestore
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> posts = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        var timestamp = data['timestamp'] as Timestamp?;
        if (timestamp != null) {
          data['timestamp'] = timestamp.toDate();
        }
        return {...data, 'id': doc.id};
      }).toList();

      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _updatePost(
      UpdatePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await _firestore.collection('posts').doc(event.postId).update({
        'message': event.updatedMessage,
      });

      emit(PostSuccess('Post updated successfully!'));
      add(FetchPostsEvent());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _deletePost(
      DeletePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await _firestore.collection('posts').doc(event.postId).delete();

      emit(PostSuccess('Post deleted successfully!'));
      add(FetchPostsEvent());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class PostEvent {}

// class AddPostEvent extends PostEvent {
//   final String message;
//   AddPostEvent(this.message);
// }

// class FetchPostsEvent extends PostEvent {}

// abstract class PostState {}

// class PostInitial extends PostState {}

// class PostLoading extends PostState {}

// class PostLoaded extends PostState {
//   final List<Map<String, dynamic>> posts;
//   PostLoaded(this.posts);
// }

// class PostError extends PostState {
//   final String errorMessage;
//   PostError(this.errorMessage);
// }

// class PostSuccess extends PostState {
//   final String message;
//   PostSuccess(this.message);
// }

// class PostBloc extends Bloc<PostEvent, PostState> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   PostBloc() : super(PostInitial()) {
//     on<AddPostEvent>((event, emit) async {
//       emit(PostLoading());
//       try {
//         String uid = FirebaseAuth.instance.currentUser!.uid;
//         DocumentSnapshot userDoc =
//             await _firestore.collection('users').doc(uid).get();
//         String username =
//             (userDoc.data() as Map<String, dynamic>)['name'] ?? 'Anonymous';

//         await _firestore.collection('posts').add({
//           'message': event.message,
//           'username': username,
//           'timestamp': FieldValue.serverTimestamp(),
//         });

//         emit(PostSuccess('Post added successfully!'));
//         add(FetchPostsEvent());
//       } catch (e) {
//         emit(PostError(e.toString()));
//       }
//     });

//     on<FetchPostsEvent>((event, emit) async {
//       emit(PostLoading());
//       try {
//         final querySnapshot = await _firestore
//             .collection('posts')
//             .orderBy('timestamp', descending: true)
//             .get();

//         List<Map<String, dynamic>> posts = querySnapshot.docs.map((doc) {
//           var data = doc.data() as Map<String, dynamic>;
//           var timestamp = data['timestamp'] as Timestamp?;
//           if (timestamp != null) {
//             data['timestamp'] = timestamp.toDate();
//           }
//           return data;
//         }).toList();

//         print('Fetched posts: $posts');
//         emit(PostLoaded(posts));
//       } catch (e) {
//         emit(PostError(e.toString()));
//       }
//     });
//   }
// }
