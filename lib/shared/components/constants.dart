import 'package:flutter_udemy/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_udemy/shared/components/components.dart';
import 'package:flutter_udemy/shared/network/local/cache_helper.dart';

/////
////

// base url     :   https://newsapi.org/
//  method(url) :     v2/top-headlines?
// queries      :   country=eg&category=business&apiKey=dbc06a8a43044e2397982881f5388160

// https://newsapi.org/
// v2/everything?
// q=tesla&apiKey=dbc06a8a43044e2397982881f5388160




// abdullahMansour
// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca


void printFullText(text) {
  final pattern = RegExp('.{1,800}'); // 800 si the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void signOut(context) => CacheHelper.removeData(
      key: 'token',
    ).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
String? token;
String? uId;
