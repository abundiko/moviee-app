import 'package:myapp/utils/dimensions.dart';
import 'package:myapp/widgets/ui/loading.dart';
import 'package:myapp/widgets/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/widgets.dart';

enum AppButtonStyle { primary, secondary }

class AppButton extends StatelessWidget {
  const AppButton.primary({
    super.key,
    this.child,
    required this.onPressed,
    this.style = AppButtonStyle.primary,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.gradientColors,
    this.height = size * 7,
    this.icon,
    this.iconBefore = false,
    this.loading = false,
    this.borderRadius,
  });

  final dynamic child;
  final Color? bgColor, borderColor, textColor;
  final List<Color>? gradientColors;
  final AppButtonStyle style;
  final Function() onPressed;
  final double height;
  final IconData? icon;
  final bool iconBefore, loading;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: loading ? .6 : 1,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: height,
        decoration: BoxDecoration(
            color: gradientColors != null
                ? gradientColors![0]
                : bgColor ??
                    (style == AppButtonStyle.primary
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark),
            borderRadius: borderRadius ?? BorderRadius.circular(size * 2),
            gradient: gradientColors == null
                ? null
                : LinearGradient(
                    colors: gradientColors!,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
            border: Border.all(
                width: 2,
                color: gradientColors != null
                    ? Colors.transparent
                    : borderColor ??
                        (style == AppButtonStyle.primary
                            ? Theme.of(context).primaryColor
                            : Colors.transparent))),
        child: MaterialButton(
          minWidth: double.maxFinite,
          height: double.maxFinite,
          onPressed: loading ? null : onPressed,
          child: Loading(
            size: size * 2,
            color: textColor ?? Colors.white,
            loading: loading,
            child: icon != null && child is String
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: iconBefore ? TextDirection.rtl : null,
                    children: [
                      textWidget(context),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        icon,
                        color: (textColor ??
                            Theme.of(context).scaffoldBackgroundColor),
                        size: size * 2,
                      )
                    ],
                  )
                : child is String
                    ? textWidget(context)
                    : child,
          ),
        ),
      ),
    );
  }

  AppText textWidget(BuildContext context) {
    return AppText.small(
      child,
      weight: FontWeight.w600,
      size: 18,
      color: (textColor ?? Theme.of(context).scaffoldBackgroundColor),
    );
  }
}

class ProceedButton extends StatelessWidget {
  const ProceedButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: AppButton.primary(
        onPressed: onPressed,
        child:
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppText.small(
            "Proceed",
            color: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Icon(
            Icons.arrow_circle_right_outlined,
            color: Colors.white,
          ),
        ]),
      ),
    );
  }
}
