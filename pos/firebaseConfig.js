import { initializeApp } from 'firebase/app';
const plist = require('plist');
const fs = require('fs');

// Path to your GoogleService-Info.plist file
const plistFilePath = './GoogleService-Info.plist';

// Read the contents of the plist file
fs.readFile(plistFilePath, 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading plist file:', err);
    return;
  }

  // Parse the plist data
  const plistData = plist.parse(data);

  // Optionally import the services that you want to use
  // import {...} from "firebase/auth";
  // import {...} from "firebase/database";
  // import {...} from "firebase/firestore";
  // import {...} from "firebase/functions";
  // import {...} from "firebase/storage";

  // Initialize Firebase
  const firebaseConfig = {
    apiKey: plistData.API_KEY,
    authDomain: plistData.BUNDLE_ID,
    databaseURL: plistData.DATABASE_URL,
    projectId: plistData.PROJECT_ID,
    storageBucket: plistData.STORAGE_BUCKET,
    messagingSenderId: plistData.GCM_SENDER_ID,
    appId: plistData.GOOGLE_APP_ID,
  };

  const app = initializeApp(firebaseConfig);
  // For more information on how to access Firebase in your project,
  // see the Firebase documentation: https://firebase.google.com/docs/web/setup#access-firebase
});
