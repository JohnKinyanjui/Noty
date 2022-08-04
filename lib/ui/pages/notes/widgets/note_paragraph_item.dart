import 'dart:io';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/models/notes.dart';

import 'package:noty/utils/themes/decorations.dart';

import 'notes_paragraph_item_options.dart';

class NoteParagraphItem extends StatelessWidget {
  final Connector connector;
  final Paragrah paragraph;
  const NoteParagraphItem(
      {Key? key, required this.connector, required this.paragraph})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Decorations.bgColor1.withOpacity(0.5),
        ),
        child: InkWell(
          onTap: () => showBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            elevation: 0,
            builder: (ctx) => NoteParagraphOptions(
              connector: connector,
              paragrah: paragraph,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: paragraph.path == "none" ? 4 : 0,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Visibility(
                visible: paragraph.path != "none",
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(File(paragraph.path)),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
              Visibility(
                visible: paragraph.description != "none",
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    paragraph.description,
                    style: Decorations.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: paragraph.link != "none",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnyLinkPreview(
                          borderRadius: 5,
                          backgroundColor: Decorations.bgColor,
                          link: paragraph.link,
                          displayDirection: UIDirection.uiDirectionHorizontal,
                          showMultimedia: true,
                          bodyMaxLines: 5,
                          boxShadow: [],
                          bodyTextOverflow: TextOverflow.ellipsis,
                          titleStyle: Decorations.style(
                            fontColor: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          bodyStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            paragraph.link,
                            style: Decorations.style(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}

class NoteParagraphItemNail extends StatelessWidget {
  final Connector connector;
  final Paragrah paragraph;
  const NoteParagraphItemNail(
      {Key? key, required this.connector, required this.paragraph})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Visibility(
        visible: paragraph.path != "none",
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: FileImage(File(paragraph.path)),
                fit: BoxFit.cover,
              )),
        ),
      ),
      Visibility(
        visible: paragraph.description != "none",
        child: Text(
          paragraph.description,
          style: Decorations.style(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            fontColor: Colors.grey,
          ),
        ),
      ),
      Visibility(
        visible: paragraph.link != "none",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnyLinkPreview(
              borderRadius: 5,
              backgroundColor: Decorations.bgColor,
              link: paragraph.link,
              displayDirection: UIDirection.uiDirectionHorizontal,
              showMultimedia: true,
              bodyMaxLines: 5,
              boxShadow: [],
              bodyTextOverflow: TextOverflow.ellipsis,
              titleStyle: Decorations.style(
                fontColor: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                paragraph.link,
                style: Decorations.style(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
