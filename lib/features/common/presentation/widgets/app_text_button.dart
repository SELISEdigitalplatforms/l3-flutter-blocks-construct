import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final bool isDisable;
  final VoidCallback onPressed;
  final String title;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;
  final double? height;
  final double? width;
  final double? elevation;
  final Color? borderColor;
  final Color? shadowColor;
  final double? buttonTextSize;
  final TextStyle? buttonTextStyle;
  final double? letterSpacing;
  final bool isUpperCase;
  final EdgeInsetsGeometry? padding;
  final bool elipsis;
  final double borderRadius;

  const AppTextButton({
    super.key,
    required this.isDisable,
    required this.onPressed,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledColor,
    this.height,
    this.width,
    this.elevation,
    this.borderColor,
    this.shadowColor,
    this.buttonTextSize,
    this.buttonTextStyle,
    this.letterSpacing,
    this.isUpperCase = false,
    this.padding,
    this.elipsis = false,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      width: elipsis ? width ?? MediaQuery.of(context).size.width : null,
      child: TextButton(
        onPressed: isDisable ? null : onPressed,
        style: TextButton.styleFrom(
          //  minimumSize: const Size(100, 40),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          elevation: elevation ?? elevation,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          side: borderColor != null
              ? BorderSide(
                  color: borderColor!,
                  width: 2,
                )
              : null,
          shape: (borderRadius > 0)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                )
              : null,
        ),
        child: SizedBox(
          width: elipsis ? width : null,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingIcon != null) leadingIcon as Widget,
              if (leadingIcon != null)
                const SizedBox(
                  width: 4,
                ),
              if (!elipsis)
                Text(
                  isUpperCase ? title.toUpperCase() : title,
                  style: buttonTextStyle ??
                      TextStyle(
                        height: 1.2,
                        color: isDisable ? disabledColor ?? Colors.white : foregroundColor ?? Colors.white,
                        letterSpacing: letterSpacing ?? 0,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w700,
                        fontSize: buttonTextSize,
                      ),
                ),
              if (elipsis)
                Flexible(
                  child: Text(
                    isUpperCase ? title.toUpperCase() : title,
                    style: buttonTextStyle ??
                        TextStyle(
                          height: 1.2,
                          color: isDisable ? disabledColor ?? Colors.white : foregroundColor ?? Colors.white,
                          letterSpacing: letterSpacing ?? 0,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                          fontSize: buttonTextSize,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (trailingIcon != null) trailingIcon as Widget,
            ],
          ),
        ),
      ),
    );
  }
}
