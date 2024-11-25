import * as functions from 'firebase-functions/v2';
import * as admin from 'firebase-admin';


admin.initializeApp();


export const newPostAdded = functions.firestore
  .onDocumentCreated('posts/{postId}', (event) => {

    if (!event.data) {
      console.error("Event data is undefined. No document snapshot available.");
      return null;
    }

  
    const newPost = event.data.data();
    console.log('New Post Added: ', newPost); 

    
    return null;
  });
