// https://newsapi.org/v2/everything?q=tesla&apiKey=5e7aeee60166446182f634efbd43fe3d

import '../network/local/cache_helper.dart';
import 'components.dart';

// void singOut(context)
// {
//   CacheHelper.removeData(
//       key: 'token'
//   ).then((value) {
//     if(value)
//     {
//       navigateAndFinish(context, ShopLoginScreen());
//     }
//   });
// }

void printFullText(String text)
{
final pattern =RegExp('.{1,800}');
pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String? uId;