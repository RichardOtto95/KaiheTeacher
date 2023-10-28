importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyDzYDJLcQjlS-bVVCaz4z7hzs9mkVVayD0",
    appId: "1:223539143896:web:29976875b9712caa85a3ad",
    messagingSenderId: "223539143896",
    projectId: "kaihe-54d62",
    storageBucket: "kaihe-54d62.appspot.com",
    authDomain: "kaihe-54d62.firebaseapp.com",
    measurementId: "G-ZG2VGM8K7L",
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});