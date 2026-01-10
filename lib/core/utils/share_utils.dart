import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static void shareText(String content) {
    // ignore: deprecated_member_use
    Share.share(content);
  }
}
