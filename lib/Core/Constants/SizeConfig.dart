import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeHorizontal;
  static double _blockSizeVertical;

  // SizeConfig(BuildContext context) {
  //   _mediaQueryData = MediaQuery.of(context);
  //   _screenWidth = _mediaQueryData.size.width;
  //   _screenHeight = _mediaQueryData.size.height;
  //   _blockSizeHorizontal = _screenWidth / 100;
  //   _blockSizeVertical = _screenHeight / 100;
  // }

  void initValues(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;
  }

  double get blockSizeHorizontal {
    return _blockSizeHorizontal;
  }

  double get blockSizeVertical {
    return _blockSizeVertical;
  }
}
