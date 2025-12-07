
import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static void shareText(String content) {
    Share.share(content);
  }
}
