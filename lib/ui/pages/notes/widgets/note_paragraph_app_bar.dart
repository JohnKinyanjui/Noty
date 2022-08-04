import 'package:flutter/material.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/utils/themes/decorations.dart';

class NoteParagraphAppBar extends StatelessWidget {
  final Note? note;
  final TextEditingController? controller;
  final Function()? onpress;
  const NoteParagraphAppBar(
      {Key? key, this.note, this.controller, this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note == null ? "Write a title" : note!.title,
                style: Decorations.style(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontColor: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8,
                      ),
                      child: Text(
                        note == null ? "none" : note!.category!,
                        style: Decorations.style(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          fontColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    note == null ? DateTime.now().toString() : note!.createdAt!,
                    style: Decorations.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      fontColor: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        IconButton(
            onPressed: onpress,
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ))
      ],
    );
  }
}
