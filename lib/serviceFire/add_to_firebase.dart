import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nookat/models/admin.dart';
import 'package:nookat/models/advert.dart';
import 'package:nookat/models/advert_category.dart';
import 'package:nookat/models/information_about_app.dart';

class AddToFirebase {
  Future<void> addCategoryToFirebase(AdvertCategory advertCategory) async {
    CollectionReference<Map<String, dynamic>> categories =
        FirebaseFirestore.instance.collection('category');
    try {
      return categories
          .add(
            {
              'title': advertCategory.title,
              'descriptions': advertCategory.description,
              'photos': advertCategory.icon,
            },
          )
          .then((value) => print("User Added"))
          .catchError(
            (error) => print("Failed to add user: $error"),
          );
    } catch (e) {
      print("add Advert To FireBase $e");
    }
  }

  Future<void> addInformationAppToFirebase(InformationAboutApp informationAboutApp) async {
    CollectionReference<Map<String, dynamic>> categories =
    FirebaseFirestore.instance.collection('information');
    try {
      return categories
          .add(
        {
          'title': informationAboutApp.title,
          'descriptions': informationAboutApp.description,
        },
      )
          .then((value) => print("User Added"))
          .catchError(
            (error) => print("Failed to add user: $error"),
      );
    } catch (e) {
      print("add Advert To FireBase $e");
    }
  }

  Future<void> addAdminToFirebase(Admin admin) async {
    CollectionReference<Map<String, dynamic>> categories =
    FirebaseFirestore.instance.collection('admin');
    try {
      return categories
          .add(
        {
          'name': admin.name,
          'descriptions': admin.description,
          'password': admin.password,
          'phone': admin.phone,
          'whatsapp': admin.whatsapp,
          'telegram': admin.telegram,
        },
      )
          .then((value) => print("User Added"))
          .catchError(
            (error) => print("Failed to add user: $error"),
      );
    } catch (e) {
      print("add Advert To FireBase $e");
    }
  }

  Future<void> addAdvertToFire(Advert advert, String collection) async {
    CollectionReference<Map<String, dynamic>> users =
    FirebaseFirestore.instance.collection(collection);
    try {
      return users
          .add(
        {
          'title': advert.title,
          'titleDescription': advert.titleDescription,
          'descriptions': advert.descriptions,
          'price': advert.price,
          'whatsapp': advert.whatsapp,
          'telegram': advert.telegram,
          'phone': advert.phone,
          'youtube': advert.youtube,
          'data': advert.data,
          'user': advert.user,
          'address': advert.address,
          'website': advert.website,
          'email': advert.email,
          'AdvertCategory': advert.advertCategory,
          'photos': advert.photos,
        },
      )
          .then((value) => print("User Added"))
          .catchError(
            (error) => print("Failed to add user: $error"),
      );
    } catch (e) {
      print("add Advert To FireBase $e");
    }
  }

}
