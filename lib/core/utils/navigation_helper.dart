import 'package:go_router/go_router.dart';

/// Stores additional route data.
class AppRouteInformation<T> {
  final T? data;
  final bool maintainState;

  AppRouteInformation({this.data, this.maintainState = true});
}

/// A helper class to manage both named and standard navigation in GoRouter.
class NavigationHelper {
  final GoRouter _router;

  /// Constructor accepting GoRouter instance.
  NavigationHelper(this._router);

  // ─────────────────────────────────────────────
  // 🚀 Named Navigation Methods
  // ─────────────────────────────────────────────

  /// Navigate using a **named route** (replaces current page).
  void goNamed<T>(String routeName,
      {T? data, Map<String, String>? pathParameters}) {
    _router.goNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      extra: AppRouteInformation<T>(data: data),
    );
  }

  /// Push a new **named route** onto the stack.
  Future<T?>? pushNamed<T>(String routeName,
      {T? data, Map<String, String>? pathParameters}) {
    return _router.pushNamed<T>(
      routeName,
      pathParameters: pathParameters ?? {},
      extra: AppRouteInformation<T>(data: data),
    );
  }

  /// Replace the current page with a **named route**.
  void replaceNamed<T>(String routeName,
      {T? data, Map<String, String>? pathParameters}) {
    _router.replaceNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      extra: AppRouteInformation<T>(data: data),
    );
  }

  // ─────────────────────────────────────────────
  // 🚀 Standard Navigation Methods
  // ─────────────────────────────────────────────

  /// Navigate using a **standard route path** (replaces current page).
  void go<T>(String path, {T? data}) {
    _router.go(
      path,
      extra: AppRouteInformation<T>(data: data),
    );
  }

  /// Push a new **standard route path** onto the stack.
  Future<T?>? push<T>(String path, {T? data}) {
    return _router.push<T>(
      path,
      extra: AppRouteInformation<T>(data: data),
    );
  }

  /// Replace the current page with a **standard route path**.
  void replace<T>(String path, {T? data}) {
    _router.replace(
      path,
      extra: AppRouteInformation<T>(data: data),
    );
  }

  Uri get currentPath => _router.routerDelegate.currentConfiguration.uri;
}
