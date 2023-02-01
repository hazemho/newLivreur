import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monlivreur/config/themes/app_theme.dart';
import 'package:monlivreur/config/utils/driver_document_data.dart';

class ItemDocumentDiver extends StatefulWidget {

  final bool requiredDocument;
  final Function(File? document) voidCallback;
  final DriverDocumentData? driverDocumentData;
  const ItemDocumentDiver({Key? key, this.driverDocumentData,
    required this.voidCallback, required this.requiredDocument}) : super(key: key);

  @override
  State<ItemDocumentDiver> createState() => _ItemDocumentDiverState();
}

class _ItemDocumentDiverState extends State<ItemDocumentDiver> {


  File? _image;
  ImagePicker picker = ImagePicker();

  _imgFromCamera() {
    picker.pickImage(source: ImageSource.camera).then((value) {
      if(value != null){
        setState(() => _image = File(value.path));
        widget.voidCallback(File(value.path));
        log('LOG : Get  Path Car Response : ${_image!.path}');
      }
    });
  }

  _imgFromGallery() async {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if(value != null){
        setState(() => _image = File(value.path));
        widget.voidCallback(File(value.path));
        log('LOG : Get  Path Car Response : ${_image!.path}');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context, isScrollControlled: true,
        isDismissible: true, clipBehavior: Clip.antiAlias,
        builder: (BuildContext context) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(color: AppThemeMode.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library, color: Colors.white,),
                    title: const Text('Galerie', style: TextStyle(color: Colors.white,),),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera, color: Colors.white,),
                  title: const Text('Camera', style: TextStyle(color: Colors.white,),),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPicker(context),
      child: Stack(fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppThemeMode.containerFieldColor,
              borderRadius: BorderRadius.circular(15),
              image: _image == null
                  ? DecorationImage(
                  image: (widget.driverDocumentData?.documentImagePath != null
                      ? NetworkImage(widget.driverDocumentData?.documentImagePath??"")
                      : AssetImage("assets/transparent_picture.png")) as ImageProvider, fit: BoxFit.cover)
                  : DecorationImage(image:  FileImage(_image!),
                  fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  decoration: BoxDecoration(color: _image == null
                      && widget.driverDocumentData?.documentImagePath == null
                      ? Colors.transparent : AppThemeMode.primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: AutoSizeText("${widget.driverDocumentData?.documentTitle}",
                    style: TextStyle(fontWeight: FontWeight.bold, color: _image == null
                        && widget.driverDocumentData?.documentImagePath == null
                        ? AppThemeMode.textColorBlack : AppThemeMode.textColorWhite,
                        fontSize: 14), textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
          Visibility(visible: _image == null && widget.driverDocumentData?.documentImagePath == null,
            child: Icon(Icons.add_photo_alternate_rounded, size: 56,
              color: widget.requiredDocument? Colors.red: Colors.black12,),
          ),
        ],
      ),
    );
  }
}
