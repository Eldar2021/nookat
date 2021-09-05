import 'package:share_plus/share_plus.dart';

class ShareService{
  void share(String text, String subText) async{
   await  Share.share(text, subject: subText);
  }
}