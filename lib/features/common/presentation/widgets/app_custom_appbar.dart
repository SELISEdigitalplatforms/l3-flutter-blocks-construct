import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/asset_helper.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/widgets/language_dropdown.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/widgets/profile_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/theme_switcher_button.dart';

class AppCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool backButton;
  final bool showLanguageSwitch;
  final bool showThemeSwitchButton;
  final bool showProfileButton;
  final bool showAppBarShadow;
  final bool showLogo;
  final List<Widget>? actions;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final void Function()? onBackButtonPressed;
  final Function()? onHelpButtonPressed;
  final Function()? onProfileButtonPressed;

  const AppCustomAppBar({
    super.key,
    this.title,
    this.backButton = false,
    this.showLanguageSwitch = false,
    this.showThemeSwitchButton = false,
    this.showProfileButton = false,
    this.showAppBarShadow = false,
    this.showLogo = true,
    this.actions,
    this.scaffoldKey,
    this.backgroundColor,
    this.foregroundColor,
    this.onBackButtonPressed,
    this.onHelpButtonPressed,
    this.onProfileButtonPressed,
    this.elevation,
  });

  static final _appBar = AppBar();

  @override
  State<AppCustomAppBar> createState() => _AppCustomAppBarState();

  @override
  Size get preferredSize => AppCustomAppBar._appBar.preferredSize;
}

class _AppCustomAppBarState extends State<AppCustomAppBar> {
  bool _isButtonEnabled = true;

  @override
  void initState() {
    debugPrint("Appbar init called");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor ??
          Theme.of(context).colorScheme.secondaryContainer,
      foregroundColor: Colors.black,
      elevation: widget.elevation ?? 0,
      automaticallyImplyLeading: false,
      shadowColor:
          widget.showAppBarShadow ? Colors.black.withOpacity(0.20) : null,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.backButton
              ? Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: widget.foregroundColor ?? Colors.black,
                        size: 28,
                      ),
                      onPressed: () =>
                          //TODO
                          // widget.onBackButtonPressed != null ? widget.onBackButtonPressed!() : context.router.maybePop(),
                          {}),
                )
              : Container(
                  width: widget.showLogo ? 20 : 56,
                ),
          if (widget.showLogo)
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Image.asset(AssetHelper.logo, height: 32),
            ),
          if (widget.title != null)
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(left: widget.showLanguageSwitch ? 24 : 0),
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    color: widget.foregroundColor ?? Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
      actions: [
        if (widget.showThemeSwitchButton)
          Container(
            padding: const EdgeInsets.only(left: 0, right: 12),
            child: ThemeSwitcherButton(),
          ),
        if (widget.showLanguageSwitch)
          Container(
            padding: const EdgeInsets.only(left: 0, right: 12),
            child: LanguageDropdown(),
          ),
        if (widget.showProfileButton)
          Container(
            padding: const EdgeInsets.only(left: 0, right: 12),
            child: ProfileButton(widget.scaffoldKey),
          ),
        ...(widget.actions ?? []),
      ],
    );
  }
}
