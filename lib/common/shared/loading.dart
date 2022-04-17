import 'package:flutter/material.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const SpinKitPouringHourGlassRefined(
        color: Constants.mainColor,
        size: 50,
      ),
    );
  }
}
