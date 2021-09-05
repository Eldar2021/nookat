
class Advert {
  final String title;
  final String? titleDescription;
  final String descriptions;
  final String? price;
  final String? whatsapp;
  final String? telegram;
  final String? phone;
  final String? youtube;
  final List<dynamic>? photos;
  final String? data;
  final String user;
  final String? address;
  final String? website;
  final String? email;
  final String? advertCategory;

  Advert({
    required this.title,
    this.titleDescription,
    required this.descriptions,
    this.price,
    this.whatsapp,
    this.telegram,
    this.phone,
    this.youtube,
    this.photos,
    required this.user,
    this.data,
    this.address,
    this.website,
    this.email,
    this.advertCategory,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'user': user,
  //     'email': email,
  //   };
  // }
  //
  // Advert.fromMap(
  //   Map<String, dynamic> map,
  //   this.title,
  //   this.titleDescription,
  //   this.descriptions,
  //   this.price,
  //   this.whatsapp,
  //   this.telegram,
  //   this.phone,
  //   this.youtube,
  //   this.photos,
  //   this.data,
  //   this.user,
  //   this.address,
  //   this.website,
  //   this.advertCategory,
  // )   : user = map['user'],
  //       email = map['email'];

}

