import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/models/information_about_app.dart';
import 'package:nookat/serviceFire/add_to_firebase.dart';
import 'package:nookat/widgets/add_advert_widgets.dart';

class AddInformationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

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
                  textEditingController: title,
                  text: "title",
                  valid: true,
                ),
                MyTextFormField(
                  textEditingController: description,
                  text: "description",
                ),
                ElevatedButton(
                  child: Text("жиберүү"),
                  onPressed: () {
                    addInformation();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addInformation() async {
    if (_formKey.currentState!.validate()) {
      try {
        InformationAboutApp informationAboutApp = InformationAboutApp(
          title: title.text,
          description: description.text,
          //advertCategory:
        );
        AddToFirebase().addInformationAppToFirebase(informationAboutApp);
        Get.back();
      } catch (e) {
        print(e);
      }
    } else {}
  }
}
