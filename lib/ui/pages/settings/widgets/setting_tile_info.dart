import 'package:flutter/material.dart';
import 'package:noty/utils/themes/decorations.dart';

class SettingInfo extends StatelessWidget {
  final String? title;
  final String? des;
  const SettingInfo({Key? key, this.title, this.des}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Decorations.bgColor1.withOpacity(0.4),
      ))),
      child: Center(
        child: ListTile(
          title: Text(
            title ?? "Ads",
            style: Decorations.style(
              fontColor: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            des ??
                "Video ads are only shown once every 24hr to improve experience, to have an adfree with extra features purchase the pro version",
            style: Decorations.style(
              fontColor: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
