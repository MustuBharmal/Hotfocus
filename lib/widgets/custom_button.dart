import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

class CustomButton extends StatefulWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.prefixWidget,
      this.suffixWidget});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  Widget? prefixWidget;

  Widget? suffixWidget;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: widget.onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (widget.prefixWidget != null || widget.suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.prefixWidget ?? SizedBox(),
          Text(
            widget.text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          widget.suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Text(
        widget.text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        getHorizontalSize(widget.width ?? 0),
        getVerticalSize(widget.height ?? 0),
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      side: _setTextButtonBorder(),
      shadowColor: _setTextButtonShadowColor(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (widget.padding) {
      case ButtonPadding.PaddingAll6:
        return getPadding(
          all: 6,
        );
      case ButtonPadding.PaddingAll3:
        return getPadding(
          all: 3,
        );
      default:
        return getPadding(
          all: 12,
        );
    }
  }

  _setColor() {
    switch (widget.variant) {
      case ButtonVariant.FillWhiteA70019:
        return ColorConstant.whiteA70090;
      case ButtonVariant.FillIndigoA200:
        return ColorConstant.indigoA200;
      case ButtonVariant.OutlineGray90005:
        return ColorConstant.indigo100;
      case ButtonVariant.OutlineGray90005_1:
        return ColorConstant.gray200;
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setTextButtonBorder() {
    switch (widget.variant) {
      case ButtonVariant.OutlineGray90005:
        return BorderSide(
          color: ColorConstant.gray90005,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGray90005_1:
        return BorderSide(
          color: ColorConstant.gray90005,
          width: getHorizontalSize(
            1.00,
          ),
        );
      default:
        return null;
        ;
    }
  }

  _setTextButtonShadowColor() {
    switch (widget.variant) {
      case ButtonVariant.OutlineGray90005:
        return ColorConstant.gray9000c;
      case ButtonVariant.OutlineGray90005_1:
        return ColorConstant.gray9000c;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (widget.shape) {
      case ButtonShape.CircleBorder16:
        return BorderRadius.circular(
          getHorizontalSize(
            16.00,
          ),
        );
      case ButtonShape.CircleBorder13:
        return BorderRadius.circular(
          getHorizontalSize(
            13.00,
          ),
        );
      case ButtonShape.CustomBorderTL20:
        return BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              20.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              8.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              20.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              20.00,
            ),
          ),
        );
      case ButtonShape.CustomBorderBL20:
        return BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              8.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              20.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              20.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              20.00,
            ),
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (widget.fontStyle) {
      case ButtonFontStyle.InterRegular15WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.NetflixSansMedium14:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Netflix Sans',
          fontWeight: FontWeight.w500,
        );
      case ButtonFontStyle.InterRegular13:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            13,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.NetflixSansMedium16:
        return TextStyle(
          color: ColorConstant.gray90001,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Netflix Sans',
          fontWeight: FontWeight.w500,
        );
      case ButtonFontStyle.InterRegular12:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      default:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder10,
  CircleBorder16,
  CircleBorder13,
  CustomBorderTL20,
  CustomBorderBL20,
}

enum ButtonPadding {
  PaddingAll12,
  PaddingAll6,
  PaddingAll3,
}

enum ButtonVariant {
  FillWhiteA700,
  FillWhiteA70019,
  FillIndigoA200,
  OutlineGray90005,
  OutlineGray90005_1,
}

enum ButtonFontStyle {
  InterRegular15,
  InterRegular15WhiteA700,
  NetflixSansMedium14,
  InterRegular13,
  NetflixSansMedium16,
  InterRegular12,
}
