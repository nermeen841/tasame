class SettingModel {
  String? message;
  Data? data;
  bool? status;
  int? statusCode;

  SettingModel({this.message, this.data, this.status, this.statusCode});

  SettingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    statusCode = json['statusCode'];
  }
}

class Data {
  String? terms;
  String? text;
  String? title;
  String? logo;
  String? mobile1;
  String? mobile2;
  String? email1;
  String? email2;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;
  String? snapchatLink;
  String? linkedinLink;
  String? pinterest;
  String? tiktok;
  String? whatsappLink;
  String? videoBg;
  String? titleAbout;
  String? aboutUs;
  String? aboutImage;
  String? textHome;
  String? textLogin;
  String? textFooter;
  String? titleSlider;
  String? textSlider;
  String? sliderImage;
  String? apptitle;
  String? apptext;
  String? iosAppLink;
  String? androidAppLink;

  Data(
      {this.terms,
      this.text,
      this.title,
      this.logo,
      this.mobile1,
      this.mobile2,
      this.email1,
      this.email2,
      this.facebookLink,
      this.twitterLink,
      this.instagramLink,
      this.snapchatLink,
      this.linkedinLink,
      this.pinterest,
      this.tiktok,
      this.whatsappLink,
      this.videoBg,
      this.titleAbout,
      this.aboutUs,
      this.aboutImage,
      this.textHome,
      this.textLogin,
      this.textFooter,
      this.titleSlider,
      this.textSlider,
      this.sliderImage,
      this.apptitle,
      this.apptext,
      this.iosAppLink,
      this.androidAppLink});

  Data.fromJson(Map<String, dynamic> json) {
    terms = json['terms'];
    text = json['text'];
    title = json['title'];
    logo = json['logo'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    email1 = json['email1'];
    email2 = json['email2'];
    facebookLink = json['facebookLink'];
    twitterLink = json['twitterLink'];
    instagramLink = json['instagramLink'];
    snapchatLink = json['snapchatLink'];
    linkedinLink = json['linkedinLink'];
    pinterest = json['pinterest'];
    tiktok = json['tiktok'];
    whatsappLink = json['whatsappLink'];
    videoBg = json['videoBg'];
    titleAbout = json['title_about'];
    aboutUs = json['aboutUs'];
    aboutImage = json['aboutImage'];
    textHome = json['text_home'];
    textLogin = json['text_login'];
    textFooter = json['text_footer'];
    titleSlider = json['title_slider'];
    textSlider = json['text_slider'];
    sliderImage = json['sliderImage'];
    apptitle = json['apptitle'];
    apptext = json['apptext'];
    iosAppLink = json['ios_app_link'];
    androidAppLink = json['android_app_link'];
  }
}
