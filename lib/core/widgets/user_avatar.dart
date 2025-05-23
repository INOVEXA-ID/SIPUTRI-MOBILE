import 'package:flutter/material.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/core/helper/user_model.dart';
import 'package:siputri_mobile/core/constants/color_constants.dart';
import 'my_text.dart'; // jika MyText custom, import di sini

class UserAvatar extends StatelessWidget {
  final double size;
  const UserAvatar({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final user = TokenStorage().user;
    if (user != null && user.foto != null && user.foto!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child: ClipOval(
          child: Image.network(
            user.foto!,
            fit: BoxFit.cover,
            width: size,
            height: size,
            errorBuilder: (context, error, stackTrace) {
              return _userInitial(user, size);
            },
          ),
        ),
      );
    }
    return _userInitial(user, size);
  }

  Widget _userInitial(User? user, double size) {
    String initials = "U";
    if (user != null && user.nama.isNotEmpty) {
      final names = user.nama.trim().split(" ");
      if (names.length == 1) {
        initials = names.first.substring(0, 1).toUpperCase();
      } else if (names.length > 1) {
        initials =
            names.first.substring(0, 1).toUpperCase() +
            names.last.substring(0, 1).toUpperCase();
      }
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: ColorConstants.primaryColor, width: 2),
      ),
      child: Center(
        child: MyText(
          title: initials,
          color: ColorConstants.primaryColor,
          textAlign: TextAlign.center,
          fontSize: size * 0.45,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
