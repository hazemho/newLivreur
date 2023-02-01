import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LivreurPopUp extends StatefulWidget {

  LivreurPopUp(this.IconPopUp, this.titre, this.colisCode, this.colisEtat, this.voidCallback);
  String IconPopUp;
  String titre;
  int? colisCode;
  int? colisEtat;
  VoidCallback voidCallback;
  @override
  State<LivreurPopUp> createState() => _LivreurPopUpState();
}

class _LivreurPopUpState extends State<LivreurPopUp> {

  final TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 8, top: 10 + 8, right: 8, bottom: 2),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: PrimaryColorY,
                    radius: 25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(widget.IconPopUp)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.titre,
                    style: myTextStyleBase.headline2,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 20,
                child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Commentaires',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PrimaryColorY),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PrimaryColorY,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context, [
                              Provider.of<LivreurColisProvider>(context,
                                listen: false).setEtatColis(widget.colisCode, widget.colisEtat,
                                  comment: textEditingController.text),
                              Provider.of<LivreurColisProvider>(context,
                                  listen: false).fetchAndSetLivreurColisById(widget.colisCode),
                              Provider.of<LivreurColisProvider>(context, listen: false)
                                .fetchAndSetAlertColis(),
                              Provider.of<LivreurColisProvider>(context, listen: false)
                                .fetchAndSetLivreurColis(null),
                              widget.voidCallback()
                            ]);

                          },
                          child: Text('Valider',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Annuler',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
