import 'package:flutter/material.dart';

Widget boxWidget(BuildContext context) {
  return Container(
    height: 45,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      color: Colors.black,
    ),
  );
}
