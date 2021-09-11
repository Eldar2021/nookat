const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

// const fcmToken = "fGMkTB6gSDy3hQRepML-EW:APA91bHnjf61FAg2MVboCk2l5X5MpZbPjSpnq6pLOegG0Q6SHiEs25EI6VghXO4_rCifxUr4qhbrmEtX5CpMN4_sqV5Gdkde_fkbsEc1Iu3rL3yfeZJt3EDpbn5Y-nChGCNaI5Go8LBK";

exports.sendNotIn = functions.firestore.document("information/{informationId}").onCreate((event) => {
  const newValue = event.data();
  console.log("almazbek uulu eldiyar");

  const payload = {
    // token: fcmToken,
    topic: "topics-all",
    notification: {
      title: newValue.title,
      body: newValue.descriptions,
    },
  };

  admin.messaging().send(payload).then((response) => {
    // Response is a message ID string.
    console.log("Successfully sent message:", response);
    return {success: true};
  }).catch((error) => {
    console.log("Error sent message:", error);
    return {error: error.code};
  });
});

exports.sendNotAd = functions.firestore.document("advert/{advertId}").onCreate((event) => {
  const newValue = event.data();
  console.log("almazbek uulu eldiyar");

  const payload = {
    // token: fcmToken,
    topic: "topics-all",
    notification: {
      title: newValue.title,
      body: newValue.descriptions,
    },
  };

  admin.messaging().send(payload).then((response) => {
    // Response is a message ID string.
    console.log("Successfully sent message:", response);
    return {success: true};
  }).catch((error) => {
    console.log("Error sent message:", error);
    return {error: error.code};
  });
});

exports.sendNotNew = functions.firestore.document("news/{newsId}").onCreate((event) => {
  const newValue = event.data();
  console.log("almazbek uulu eldiyar");

  const payload = {
    // token: fcmToken,
    topic: "topics-all",
    notification: {
      title: newValue.title,
      body: newValue.descriptions,
    },
  };

  admin.messaging().send(payload).then((response) => {
    // Response is a message ID string.
    console.log("Successfully sent message:", response);
    return {success: true};
  }).catch((error) => {
    console.log("Error sent message:", error);
    return {error: error.code};
  });
});

exports.sendNotUr = functions.firestore.document("urgent/{urgentId}").onCreate((event) => {
  const newValue = event.data();
  console.log("almazbek uulu eldiyar");

  const payload = {
    // token: fcmToken,
    topic: "topics-all",
    notification: {
      title: newValue.title,
      body: newValue.descriptions,
    },
  };

  admin.messaging().send(payload).then((response) => {
    // Response is a message ID string.
    console.log("Successfully sent message:", response);
    return {success: true};
  }).catch((error) => {
    console.log("Error sent message:", error);
    return {error: error.code};
  });
});
