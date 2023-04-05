import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/myaccount/model/tutuor_model.dart';
import '../../../../core/constants/constants.dart';

class UpdateTutorProfileAction extends ApiRequestAction<TutorProfileModel> {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String birthdate;
  final String cv;
  final int gender;
  final List<int> specialicity;
  final List<int> language;
  final List<int> rate;
  final List<int> credits;
  final dynamic image;
  final dynamic video;
  final dynamic positionFile;
  final String bankname;
  final String bankCountry;
  final String iban;
  final String swiftcode;
  final String accountNumber;
  final String position;
  final String bio;

  UpdateTutorProfileAction({
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
    this.positionFile,
    required this.rate,
    required this.image,
    this.video,
    required this.bankname,
    required this.bankCountry,
    required this.iban,
    required this.swiftcode,
    required this.accountNumber,
    required this.position,
    required this.bio,
  });

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => "/update-tutor-profile";

  @override
  bool get authRequired => true;

  @override
  ContentDataType? get contentDataType => ContentDataType.formData;

  @override
  Map<String, dynamic> get toMap => {
        "name": name,
        "mobile": phone,
        "email": email,
        "gender": gender.toString(),
        "password": password,
        "countryId": prefs.getInt("countryId")!,
        "birthday": birthdate,
        "ar[cv]": cv,
        "en[cv]": cv,
        "ar[bio]": bio,
        "en[bio]": bio,
        "image": image,
        "video": video,
        "language_id": language,
        "rate": rate,
        "credit_id": credits,
        "file_position": positionFile,
        "specialty_id": specialicity,
        "bankName": bankname,
        "countryBankName": bankCountry,
        "accountNo": accountNumber,
        "ipan": iban,
        "swiftCode": swiftcode,
        "position": position,
      };

  @override
  ResponseBuilder<TutorProfileModel> get responseBuilder =>
      (json) => TutorProfileModel.fromJson(json);
}
