import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConstant {
  static Color black9007f = fromHex('#7f000000');

  static Color whiteA70090 = fromHex('#90ffffff');

  static Color black9003f = fromHex('#3f000000');

  static Color black90087 = fromHex('#87000000');

  static Color gray50B2 = fromHex('#b2fafafa');

  static Color gray9000c = fromHex('#0c232323');

  static Color black90000 = fromHex('#00000000');

  static Color whiteA70019 = fromHex('#19ffffff');

  static Color blueGray900 = fromHex('#0a1f44');

  static Color deepOrange100 = fromHex('#ffb4b4');

  static Color gray600 = fromHex('#717171');

  static Color tealA700 = fromHex('#00cc99');

  static Color whiteA7004c = fromHex('#4cffffff');

  static Color black9000a = fromHex('#0a000000');

  static Color gray90026 = fromHex('#26232323');

  static Color gray400 = fromHex('#b9b9b9');

  static Color blue900 = fromHex('#1c4d97');

  static Color blueGray100 = fromHex('#d9d9d9');

  static Color whiteA7000c = fromHex('#0cffffff');

  static Color gray800 = fromHex('#3f3f3f');

  static Color gray2004c = fromHex('#4ce8e8e8');

  static Color amber300 = fromHex('#ffdb5c');

  static Color gray200 = fromHex('#ebebeb');

  static Color whiteA70063 = fromHex('#63ffffff');

  static Color whiteA70026 = fromHex('#26ffffff');

  static Color bluegray400 = fromHex('#888888');

  static Color black90019 = fromHex('#19000000');

  static Color whiteA700 = fromHex('#ffffff');

  static Color indigoA200 = fromHex('#5458f7');

  static Color gray50 = fromHex('#fafafa');

  static Color gray10019 = fromHex('#19f7f7f7');

  static Color green400 = fromHex('#4cd964');

  static Color whiteA70033 = fromHex('#33ffffff');

  static Color black90066 = fromHex('#66000000');

  static Color black900 = fromHex('#000000');

  static Color blueGray1007f = fromHex('#7fd9d9d9');

  static Color gray50001 = fromHex('#979797');

  static Color deepOrange400 = fromHex('#ff7a50');

  static Color black900A2 = fromHex('#a2000000');

  static Color whiteA7006c = fromHex('#6cffffff');

  static Color gray60002 = fromHex('#6f6f6f');

  static Color gray500 = fromHex('#919191');

  static Color gray60001 = fromHex('#838383');

  static Color gray90005 = fromHex('#05232323');

  static Color blueGray400 = fromHex('#8b8b8b');

  static Color gray90000 = fromHex('#00232323');

  static Color gray900 = fromHex('#292929');

  static Color gray90001 = fromHex('#232323');

  static Color gray300 = fromHex('#dddcdc');

  static Color gray30001 = fromHex('#dadada');

  static Color gray3007f = fromHex('#7fdddcdc');

  static Color indigo100 = fromHex('#cfd7f2');
  static Color storyColor = fromHex('#FF7A51');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
