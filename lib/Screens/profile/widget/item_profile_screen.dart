import 'package:flutter/material.dart';

class ItemProfileScreen extends StatelessWidget {

  final bool isNavigator;
  final String? title;
  final String? description;
  final IconData iconData;
  final VoidCallback voidCallback;
  const ItemProfileScreen({Key? key,
    required this.voidCallback, this.title, this.isNavigator = true,
    this.description, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
