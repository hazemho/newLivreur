library easy_dialog;

import 'package:flutter/material.dart';

class EasyDialog {
  final ImageProvider? topImage;
  final Text? title;
  final Text? description;
  final bool closeButton;
  final double width;
  final double fogOpacity;
  final double cornerRadius;
  final Color cardColor;
  final List<Widget> _contentList = [];
  List<Widget>? contentList;
  EdgeInsets? contentPadding;
  EdgeInsets? titlePadding;
  EdgeInsets descriptionPadding;
  CrossAxisAlignment contentListAlignment;

  EasyDialog(
      {Key? key,
        this.topImage,
        this.title,
        this.description,
        this.closeButton = true,
        this.width = 300,
        this.cornerRadius = 15.0,
        this.fogOpacity = 0.37,
        this.cardColor = const Color.fromRGBO(240, 240, 240, 1.0),
        this.contentList,
        this.contentPadding = const EdgeInsets.fromLTRB(17.5, 15.0, 17.5, 13.0),
        this.descriptionPadding = const EdgeInsets.all(0.0),
        this.titlePadding = const EdgeInsets.only(bottom: 12.0),
        this.contentListAlignment = CrossAxisAlignment.center})
      : assert(fogOpacity >= 0 && fogOpacity <= 1.0);

  insertByIndex(EdgeInsets? padding, Widget? child, int index) {
    _contentList.insert(
        index,
        Container(
          padding: padding,
          alignment: Alignment.center,
          child: child,
        ));
  }

  show(BuildContext context) {
    ClipRRect? image;
    if (topImage != null) {
      image = ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius)),
        child: Image(image: topImage!),
      );
    }

    if (title != null && description != null) {
      insertByIndex(titlePadding, title, 0);
      insertByIndex(descriptionPadding, description, 1);
    }
    if (title != null && description == null) {
      insertByIndex(titlePadding, title, 0);
    }
    if (description != null && title == null) {
      insertByIndex(descriptionPadding, description, 0);
    }

    contentList?.forEach((element) {
      insertByIndex(EdgeInsets.zero, element, _contentList.length);
    });

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            color: Color.fromRGBO(0, 0, 0, fogOpacity),
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        spreadRadius: 1.0,
                        color: Colors.black54,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 30.0,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                        Radius.circular(cornerRadius)),
                    color: cardColor,
                  ),
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          image ?? Container(
                            alignment: Alignment.center,
                            padding: contentPadding,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: contentListAlignment,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _contentList,
                            ),
                          ),
                          closeButton == true ? Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10
                            ), height: 26,
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 19,
                              ),
                            ),
                          ) : Container(),
                        ],
                      ),
                      image == null ? Container() :
                      Expanded(
                        child: Container(
                          padding: contentPadding,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: contentListAlignment,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _contentList,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}