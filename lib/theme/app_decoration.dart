import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get outlineBlack90066 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90066,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              3,
            ),
          ),
        ],
      );
  static BoxDecoration get fillBluegray100 => BoxDecoration(
        color: ColorConstant.blueGray100,
      );
  static BoxDecoration get fillBlack900 => BoxDecoration(
        color: ColorConstant.black900,
      );
  static BoxDecoration get outline => BoxDecoration();
  static BoxDecoration get gradientBlack9007fBluegray1007f => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0.5,
            0,
          ),
          end: Alignment(
            0.5,
            1,
          ),
          colors: [
            ColorConstant.black9007f,
            ColorConstant.blueGray1007f,
          ],
        ),
      );
  static BoxDecoration get outlineWhiteA70033 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.whiteA70033,
          width: getHorizontalSize(
            2.00,
          ),
        ),
      );
  static BoxDecoration get fillWhiteA70063 => BoxDecoration(
        color: ColorConstant.whiteA70063,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get txtFillTealA700 => BoxDecoration(
        color: ColorConstant.tealA700,
      );
  static BoxDecoration get txtFillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get fillBlue900 => BoxDecoration(
        color: ColorConstant.blue900,
      );
  static BoxDecoration get gradientGray90026Gray90026 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0.5,
            0,
          ),
          end: Alignment(
            0.5,
            1,
          ),
          colors: [
            ColorConstant.gray90026,
            ColorConstant.gray90000,
            ColorConstant.gray90026,
          ],
        ),
      );
  static BoxDecoration get fillWhiteA70026 => BoxDecoration(
        color: ColorConstant.whiteA70026,
      );
  static BoxDecoration get outlineBlack9003f => BoxDecoration();
  static BoxDecoration get gradientBlack900Black90000 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0.5,
            -0.21,
          ),
          end: Alignment(
            0.5,
            0.81,
          ),
          colors: [
            ColorConstant.black900,
            ColorConstant.black900A2,
            ColorConstant.black90000,
          ],
        ),
      );
  static BoxDecoration get gradientBlack90000Black900 => BoxDecoration(
        color: ColorConstant.black900,
        gradient: LinearGradient(
          begin: Alignment(
            0.5,
            0,
          ),
          end: Alignment(
            0.5,
            1,
          ),
          colors: [
            ColorConstant.black90000,
            ColorConstant.black90087,
            ColorConstant.black900,
          ],
        ),
      );
  static BoxDecoration get fillGray60002 => BoxDecoration(
        color: ColorConstant.gray60002,
      );
}

class BorderRadiusStyle {
  static BorderRadius customBorderTL30 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        30.00,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        30.00,
      ),
    ),
  );

  static BorderRadius customBorderBL12 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        12.00,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        12.00,
      ),
    ),
  );

  static BorderRadius customBorderBL23 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        23.00,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        23.00,
      ),
    ),
  );

  static BorderRadius customBorderTL12 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        12.00,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        12.00,
      ),
    ),
  );

  static BorderRadius customBorderTL23 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        23.00,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        23.00,
      ),
    ),
  );

  static BorderRadius txtRoundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12.00,
    ),
  );

  static BorderRadius circleBorder6 = BorderRadius.circular(
    getHorizontalSize(
      6.00,
    ),
  );

  static BorderRadius roundedBorder38 = BorderRadius.circular(
    getHorizontalSize(
      38.00,
    ),
  );

  static BorderRadius roundedBorder28 = BorderRadius.circular(
    getHorizontalSize(
      28.00,
    ),
  );

  static BorderRadius circleBorder45 = BorderRadius.circular(
    getHorizontalSize(
      45.00,
    ),
  );

  static BorderRadius roundedBorder17 = BorderRadius.circular(
    getHorizontalSize(
      17.00,
    ),
  );

  static BorderRadius circleBorder14 = BorderRadius.circular(
    getHorizontalSize(
      14.00,
    ),
  );

  static BorderRadius circleBorder25 = BorderRadius.circular(
    getHorizontalSize(
      25.00,
    ),
  );

  static BorderRadius circleBorder41 = BorderRadius.circular(
    getHorizontalSize(
      41.00,
    ),
  );

  static BorderRadius roundedBorder10 = BorderRadius.circular(
    getHorizontalSize(
      10.00,
    ),
  );

  static BorderRadius circleBorder60 = BorderRadius.circular(
    getHorizontalSize(
      60.00,
    ),
  );

  static BorderRadius circleBorder50 = BorderRadius.circular(
    getHorizontalSize(
      50.00,
    ),
  );

  static BorderRadius txtCircleBorder25 = BorderRadius.circular(
    getHorizontalSize(
      25.00,
    ),
  );
}
