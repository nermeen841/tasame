import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';

class UpdateTutorProfileModel {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String birthdate;
  final String cv;
  final int gender;
  final int specialicity;
  final List<int> language;
  final List<int> credits;
  final MultipartFile creditFile;
  final MultipartFile image;
  final MultipartFile? video;
  final String bankname;
  final String bankCountry;
  final String iban;
  final String swiftcode;
  final String accountNumber;
  final String position;

  UpdateTutorProfileModel.fromMap({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.birthdate,
    required this.cv,
    required this.gender,
    required this.specialicity,
    required this.language,
    required this.credits,
    required this.creditFile,
    required this.image,
    this.video,
    required this.bankname,
    required this.bankCountry,
    required this.iban,
    required this.swiftcode,
    required this.accountNumber,
    required this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "mobile": phone,
      "email": email,
      "gender": gender.toString(),
      "password": password,
      "countryId": prefs.getInt("countryId")!,
      "birthday": birthdate,
      "ar[cv]": cv,
      "image": image,
      "video": video,
      "language_id": language,
      "credit_id": credits,
      "credit_file": creditFile,
      "specialty_id": specialicity,
      "bankName": bankname,
      "countryBankName": bankCountry,
      "accountNo": accountNumber,
      "ipan": iban,
      "swiftCode": swiftcode,
      "position": position,
    };
  }
}
