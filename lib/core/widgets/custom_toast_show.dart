import 'package:fluttertoast/fluttertoast.dart';
import '../Const/app_colors.dart';

class ToastClass{
  void showCustomToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.black,
      textColor: AppColors.whitish,
      fontSize: 14,
    );
  }
}
