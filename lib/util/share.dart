import 'package:app_flutter/app/entities/product_entities.dart';
import 'package:flutter_share/flutter_share.dart';

class ShareUtil {
  static shareLink(
    String link, {
    String title = "Compartilhando",
    String subtitle = "Compatilhando com",
    String chooserTitle = "Compartilhar com",
  }) async {
    await FlutterShare.share(
      title: title,
      text: subtitle,
      chooserTitle: chooserTitle,
      linkUrl: link,
    );
  }

  void compartilhar(Product produto) async {
    await ShareUtil.shareLink(produto.site);
  }
}
