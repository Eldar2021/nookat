import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/models/admin.dart';
import 'package:nookat/views/admin/admin_screen.dart';
import 'package:nookat/widgets/add_advert_widgets.dart';

class AdminControlScreen extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('admin').snapshots();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTextFormField(
                  textEditingController: name,
                  text: "name",
                  valid: true,
                ),
                MyTextFormField(
                  textEditingController: password,
                  text: "password",
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    Admin admin = Admin(
                      description: data['descriptions'],
                      name: data['name'],
                      password: data["password"],
                      whatsapp: data['whatsapp'],
                      telegram: data["telegram"],
                      phone: data["phone"],
                    );
                    return ElevatedButton(
                      child: Text("жиберүү"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (name.text == admin.name && password.text == admin.password) {
                            Get.to(AdminScreen(admin: admin));
                          } else {
                            Get.snackbar("Ката", "Админ аты же сы сөз ката");
                          }
                        } else {
                          Get.snackbar("Ката", "Админ аты же сы сөз ката");
                        }
                      },
                    );
                  }).toList(),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
