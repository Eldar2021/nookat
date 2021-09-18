import 'package:flutter/material.dart';
import 'package:nookat/models/category_model.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:get/get.dart';

class CategoryDropdown extends StatelessWidget {

  CategoryDropdown({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: SelectFormField(
        controller: textEditingController,
        type: SelectFormFieldType.dropdown,
        labelText: 'Категория'.tr,
        items: categoriesForAdd,
        onChanged: (val) => print(val),
        onSaved: (val) {
          print(val);
        },
      ),
    );
  }
}
