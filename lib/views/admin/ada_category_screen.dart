import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/models/advert_category.dart';
import 'package:nookat/serviceFire/add_to_firebase.dart';
import 'package:nookat/widgets/add_advert_widgets.dart';

class AddCategoryScreen extends StatelessWidget {

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
                    if (_formKey.currentState!.validate()){

                    }else{
                      print("category Form inValid");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> addCategory() async {
    if (_formKey.currentState!.validate()) {
      try {
        AdvertCategory newAdvertCategory = AdvertCategory(
          title: title.text,
          description: description.text,
        );
        AddToFirebase().addCategoryToFirebase(newAdvertCategory);
        Get.back();
      } catch (e) {
        print("category Form inValid $e");
      }
    } else {
    }
  }

}
