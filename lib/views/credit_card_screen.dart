import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/controler/ad_advert_cotroller.dart';
import 'package:nookat/controler/credit_card_controller.dart';

class CreditCardScreen extends StatelessWidget {
  final AddAdvertController addAdvertController = Get.find();
  final CreditCardController creditCardController = Get.put(CreditCardController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Obx(
                () => CreditCardWidget(
                  cardNumber: creditCardController.cardNumber.value,
                  expiryDate: creditCardController.expiryDate.value,
                  cardHolderName: creditCardController.cardHolderName.value,
                  cvvCode: creditCardController.cvvCode.value,
                  showBackView: creditCardController.isCvvFocused.value,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                ),
              ),
              Column(
                children: [
                  Container(
                    child: CreditCardForm(
                      formKey: formKey,
                      cardNumber: creditCardController.cardNumber.value,
                      expiryDate: creditCardController.expiryDate.value,
                      cardHolderName: creditCardController.cardHolderName.value,
                      cvvCode: creditCardController.cvvCode.value,
                      themeColor: MyColors.whiteColor,
                      onCreditCardModelChange: creditCardController.onCreditCardModelChange,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumberDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Картанын Номери'.tr,
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Жарамдуулук мөөнөтү'.tr,
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Карт ээсинин аты'.tr,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xff1b447b),
                      ),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Жиберүү'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        addAdvertController.toFire();
                      } else {
                        print('invalid!');
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
