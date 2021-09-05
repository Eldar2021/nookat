import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/models/admin.dart';
import 'package:nookat/serviceFire/add_to_firebase.dart';
import 'package:nookat/widgets/add_advert_widgets.dart';

class AddAdminScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController whatsapp = TextEditingController();
  final TextEditingController telegram = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap:()=> FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
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
                  valid: true,
                ),
                MyTextFormField(
                  textEditingController: phone,
                  text: "phone",
                  valid: true,
                ),
                MyTextFormField(
                  textEditingController: whatsapp,
                  text: "whatsapp",
                  valid: true,
                ),
                MyTextFormField(
                  textEditingController: telegram,
                  text: "telegram",
                  valid: true,
                ),
                MyTextFormField(
                  textEditingController: description,
                  text: "description",
                  valid: true,
                ),
                ElevatedButton(
                  child: Text("жиберүү"),
                  onPressed: () {
                    addAdmin();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addAdmin() async {
    if (_formKey.currentState!.validate()) {
      try {
        Admin admin = Admin(
          name: name.text,
          description: description.text,
          whatsapp: whatsapp.text,
          phone: phone.text,
          telegram: telegram.text,
          password: password.text,
          //advertCategory:
        );
        AddToFirebase().addAdminToFirebase(admin);
        Get.back();
      } catch (e) {
        print(e);
      }
    } else {}
  }
}
