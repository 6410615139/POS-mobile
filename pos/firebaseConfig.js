// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth } from "firebase/auth";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCrbnazmVrAP6QtZzbPpm6wZZCgBf-1IOU",
  authDomain: "point-of-sale-261cd.firebaseapp.com",
  projectId: "point-of-sale-261cd",
  storageBucket: "point-of-sale-261cd.appspot.com",
  messagingSenderId: "184658890457",
  appId: "1:184658890457:web:4d516bbc8c37cd330d78c8",
  measurementId: "G-019CN97TDT"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);