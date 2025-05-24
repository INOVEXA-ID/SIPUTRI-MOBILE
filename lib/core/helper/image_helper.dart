import 'package:siputri_mobile/core/constants/api_constants.dart';

String? getFullImageUrl(String? path) {
  if (path == null || path.isEmpty) return null;
  if (path.startsWith('http')) return path;
  final base = ApiConstants.baseUrlImage;
  if (base == null) return null;
  if (path.startsWith('/')) {
    return '$base$path';
  } else {
    return '$base/$path';
  }
}
