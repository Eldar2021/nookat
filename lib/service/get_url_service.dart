import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class UrlService {

  void launchWhatsApp(String? whatsapp, String msg) async {
    final link = WhatsAppUnilink(
      phoneNumber: whatsapp,
      text: msg,
    );
    await launch('$link');
  }

  void launchTelegram(String? name) async {
    String url = "https://t.me/$name";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchCaller(String? tel) async {
    String url = "tel:$tel";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEmail(String? email) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }

  void launchURL(String? web) async {
    String url = web!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
