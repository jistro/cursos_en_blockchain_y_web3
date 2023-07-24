// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore, collection, getDocs, addDoc, deleteDoc, doc } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyBm0J78Lcsaax2k1HZIDRKEj8X38LlINiE",
    authDomain: "markdown-notes-32bbe.firebaseapp.com",
    projectId: "markdown-notes-32bbe",
    storageBucket: "markdown-notes-32bbe.appspot.com",
    messagingSenderId: "1016021990169",
    appId: "1:1016021990169:web:6df2deed77654457ade388"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const db = getFirestore(app)
export const notesCollection = collection(db, "notes")