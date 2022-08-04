import 'package:flutter/material.dart';
import 'package:noty/utils/themes/decorations.dart';

class NavBarItem extends StatelessWidget {
  final String label;
  final bool active;
  final Function()? onpress;
  const NavBarItem(
      {Key? key, required this.label, this.active = false, this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      child: InkWell(
        onTap: onpress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: Decorations.style(
                  fontSize: 12,
                  fontWeight: active ? FontWeight.bold : FontWeight.w600,
                  fontColor: active ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
