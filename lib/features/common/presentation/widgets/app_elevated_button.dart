import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final bool isDisable;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final VoidCallback onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final Color? circularProgressColor;
  final double? height;
  final double? width;
  final double? elevation;
  final Color? borderColor;
  final double? borderWidth;
  final Color? shadowColor;
  final TextStyle? buttonTextStyle;
  final bool isUppercase;
  final double? letterSpacing;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? buttonTextSize;
  final bool elipsis;

  const AppElevatedButton({
    super.key,
    this.isDisable = false,
    this.isLoading = false,
    required this.onPressed,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledTextColor,
    this.height,
    this.width = double.infinity,
    this.elevation = 0,
    this.borderColor,
    this.shadowColor,
    this.buttonTextStyle,
    this.letterSpacing,
    this.isUppercase = true,
    this.borderWidth,
    this.borderRadius = 4,
    this.padding,
    this.buttonTextSize,
    this.elipsis = false,
    this.circularProgressColor,
    this.disabledBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? 52;
    return SizedBox(
      height: buttonHeight,
      width: elipsis ? width ?? MediaQuery.of(context).size.width : null,
      child: ElevatedButton(
        onPressed: isDisable ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          elevation: elevation,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          disabledBackgroundColor: disabledBackgroundColor,
          side: borderColor != null
              ? BorderSide(
                  color: borderColor!,
                  width: borderWidth ?? 1,
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
            children: [
              if (leadingIcon != null) leadingIcon as Widget,
              if (leadingIcon != null)
                const SizedBox(
                  width: 4,
                ),
              if (!isLoading && !elipsis) buildButtonText(context),
              if (!isLoading && elipsis)
                Flexible(
                  child: buildButtonText(context),
                ),
              if (isLoading)
                SizedBox(
                  width: buttonHeight * 0.3,
                  height: buttonHeight * 0.3,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: foregroundColor ?? Theme.of(context).colorScheme.primary,
                  ),
                ),
              if (trailingIcon != null) trailingIcon as Widget,
            ],
          ),
        ),
      ),
    );
  }

  Text buildButtonText(BuildContext context) {
    return Text(
      isUppercase ? title.toUpperCase() : title,
      softWrap: false,
      style: buttonTextStyle ??
          TextStyle(
            height: 1.2,
            color: isDisable
                ? disabledTextColor ?? Theme.of(context).colorScheme.primary
                : foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
            letterSpacing: letterSpacing ?? 0,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w700,
            fontSize: buttonTextSize,
          ),
      textAlign: TextAlign.center,
    );
  }
}
