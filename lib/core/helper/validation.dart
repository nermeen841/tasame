// ignore_for_file: unused_local_variable
import '../constants/constants.dart';

validateName(String value) {
  if (value.isEmpty) {
    return translateString('you should enter user name',
        'يرجي ادخال اسم المستخدم', "kullanıcı adı girmelisiniz");
  }
  // else if (!regExp.hasMatch(value)) {
  //   return "Name must be a-z and A-Z";
  //}
  return null;
}

validate(String value) {
  if (value.isEmpty) {
    return translateString(
        "This field is required", "هذا الحقل مطلوب", "Bu alan gereklidir");
  }
  return null;
}

// validateNumber(String value, String message) {
//   Pattern pattern = r'^[0-9]+$';
//   if (value[0] != '5') {
//     return "يجب ان يبدا رقم الجوال ب5";
//   }
//   if (value.length != 9) {
//     return " يجب ان يكون 9 ارقام ";
//   }
//   RegExp regex = RegExp(pattern.toString());
//   if (!regex.hasMatch(value)) return message;
//   return null;
// }

validatePassword(String value) {
  Pattern pattern = r'^.{6,}$';
  RegExp regex = RegExp(pattern.toString());
  if (value.isEmpty) {
    return translateString('you should enter password', 'يجب ادخال كلمة المرور',
        'şifreyi girmelisiniz');
  } else if (!regex.hasMatch(value)) {
    return translateString(
        'password must be more than 6',
        'يجب ان تكون كلمه المرور اكبر من 6 ارقام ',
        "şifre 6'dan büyük olmalıdır");
  }
  return null;
}

validateConfirmPassword(String value, String confirm) {
  Pattern pattern = r'^.{6,}$';
  RegExp regex = RegExp(pattern.toString());
  if (value.isEmpty) {
    return translateString('you should enter password', 'يجب ادخال كلمة المرور',
        "şifre girmelisin");
  } else if (value != confirm) {
    return translateString('passwords must be equal',
        'يجب ان تكونا كلمتا المرور متطابقتين', "şifreler eşit olmalıdır");
  }
  return null;
}

validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (value.isEmpty) {
    return translateString(
        "email is required", "البريد الالكتروني مطلوب", "Email gereklidir");
  } else if (!regex.hasMatch(value)) {
    return translateString('you should enter valid Email',
        'يجب ادخل البريد الالكتروني بشكل صحيح', 'geçerli E-posta girmelisiniz');
  }
  return null;
}

// validateMobile(String value) {
//   String patttern = r'(^[0-9]*$)';
//   RegExp regExp = RegExp(patttern);
//   if (value.isEmpty) {
//     return translateString(
//         'you should enter phone number', 'يجب ادخل رقم الهاتف ', '');
//   } else if (value.length != 10) {
//     return translateString(
//         "mobile phone must 10 digits", 'رقم الهاتف يجب ان يكون 10 ارقام', '');
//   } else if (!regExp.hasMatch(value)) {
//     return translateString(
//         "mobile phone must digits", 'رقم الهاتف يجب ان يكون ارقام', '');
//   }

//   return null;
// }
