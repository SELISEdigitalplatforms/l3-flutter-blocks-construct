import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_auth_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/navigation_helper.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/screens/email_sent_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/screens/login_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/screens/signup_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/home/presentation/screens/home_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/presentation/screens/iam_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/more/presentation/screens/more_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/screens/enable_biometric_auth_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/screens/manage_auth_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/screens/password_updated_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/screens/profile_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/screens/setup_auth_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/screens/two_factor_auth_screen.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/splash/presentation/screens/splash_screen.dart';

import '../features/profile/presentation/screens/change_password_screen.dart';
import 'app_routes.dart';

/// Global navigator key for managing navigation state
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Singleton class for managing GoRouter instance
class AppRouter {
  /// Singleton instance
  static final AppRouter instance = AppRouter._internal();

  /// Private constructor
  AppRouter._internal();

  late final NavigationHelper navigation = NavigationHelper(_router);

  /// GoRouter instance
  late final GoRouter _router = _initRouter();

  /// Getter for router instance
  GoRouter get router => _router;

  /// Initialize GoRouter
  GoRouter _initRouter() {
    return GoRouter(
      initialLocation: AppRoutes.splash.path,
      debugLogDiagnostics: true,
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          name: AppRoutes.splash.name,
          path: AppRoutes.splash.path,
          builder: (context, state) => const SplashScreen(),
        ),
        StatefulShellRoute.indexedStack(
          redirect: sl<IAuthService>().authRedirect,
          builder: (context, index, navigatorShell) => HomeScreen(
            navigationShell: navigatorShell,
          ),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: AppRoutes.dashboard.name,
                  path: AppRoutes.dashboard.path,
                  builder: (context, state) => const DashboardScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: AppRoutes.iam.name,
                  path: AppRoutes.iam.path,
                  builder: (context, state) => const IAMScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: AppRoutes.inventory.name,
                  path: AppRoutes.inventory.path,
                  builder: (context, state) => const InventoryScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: AppRoutes.more.name,
                  path: AppRoutes.more.path,
                  builder: (context, state) => const MoreScreen(),
                ),
              ],
            ),
            // StatefulShellBranch(
            //   routes: <RouteBase>[
            //     GoRoute(
            //       name: AppRoutes.profile.name,
            //       path: AppRoutes.profile.path,
            //       builder: (context, state) => const ProfileScreen(),
            //       routes: [
            //         GoRoute(
            //           parentNavigatorKey: navigatorKey,
            //           name: AppRoutes.editProfile.name,
            //           path: AppRoutes.editProfile.path,
            //           builder: (context, state) => const EditProfileScreen(),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
        GoRoute(
          name: AppRoutes.profile.name,
          path: AppRoutes.profile.path,
          builder: (context, state) {
            final previousRoute = state.uri.queryParameters['previousRoute'];
            return ProfileScreen(
              previousRoute: AppRoutes.fromPath(previousRoute!),
            );
          },
          routes: [
            GoRoute(
              parentNavigatorKey: navigatorKey,
              name: AppRoutes.editProfile.name,
              path: AppRoutes.editProfile.path,
              builder: (context, state) => EditProfileScreen(),
            ),
            GoRoute(
              parentNavigatorKey: navigatorKey,
              name: AppRoutes.changePassword.name,
              path: AppRoutes.changePassword.path,
              builder: (context, state) => const ChangePasswordScreen(),
            ),
            GoRoute(
              parentNavigatorKey: navigatorKey,
              name: AppRoutes.passwordUpdated.name,
              path: AppRoutes.passwordUpdated.path,
              builder: (context, state) => const PasswordUpdatedScreen(),
            ),
            GoRoute(
              parentNavigatorKey: navigatorKey,
              name: AppRoutes.enableBiometric.name,
              path: AppRoutes.enableBiometric.path,
              builder: (context, state) => const BiometricAuthScreen(),
            ),
          ],
        ),
        GoRoute(
          name: AppRoutes.login.name,
          path: AppRoutes.login.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: AppRoutes.signUp.name,
          path: AppRoutes.signUp.path,
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          name: AppRoutes.forgotPass.name,
          path: AppRoutes.forgotPass.path,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          name: AppRoutes.emailSent.name,
          path: AppRoutes.emailSent.path,
          builder: (context, state) => const EmailSentScreen(),
        ),
        GoRoute(
          name: AppRoutes.twoFactorAuth.name,
          path: AppRoutes.twoFactorAuth.path,
          builder: (context, state) => const TwoFactorAuthenticationScreen(),
        ),
        GoRoute(
          name: AppRoutes.setupAuth.name,
          path: AppRoutes.setupAuth.path,
          builder: (context, state) => const SetupAuthenticationScreen(),
        ),
        GoRoute(
          name: AppRoutes.manageAuth.name,
          path: AppRoutes.manageAuth.path,
          builder: (context, state) => const ManageAuthenticationScreen(),
        ),
        GoRoute(
          name: AppRoutes.resetPassword.name,
          path: AppRoutes.resetPassword.path,
          builder: (context, state) => ResetPasswordScreen(
              // resetCode: state.uri.queryParameters['resetCode'] ?? "",
              ),
        ),

        // GoRoute(
        //   name: AppRoutes.detailsName,
        //   path: AppRoutes.details,
        //   builder: (context, state) {
        //     final id = state.pathParameters['id'];
        //     return MyDemoPage(title: 'Details for $id');
        //   },
        // ),
      ],
      redirect: (context, state) {
        if (state.uri.scheme.isNotEmpty) {
          String featureName = state.uri.host;
          return state.uri.host.isNotEmpty ? "/$featureName" : '/';
        }
        return null;
      },
    );
  }
}

/// For redirection on condition
/**
 * GoRoute(
    path: FavouriteAdListScreen.path,
    redirect: (context, state) async {
    final accessToken = await PreferenceUtils(sl())
    .getString(CacheConstants.accessTokenKey);
    final userId =
    await PreferenceUtils(sl()).getInt(CacheConstants.userIdKey);
    if ((accessToken.isEmpty || userId == null)) {
    return LoginScreen.path;
    }

    return null;
    },
    builder: (context, state) => const FavouriteAdListScreen(),
    ),
    <<<<<<< HEAD
 */

/// Go to a Static Named Route
/**
 * AppRouter.instance.go(AppRoutes.profileName);
 * AppRouter.instance.push(AppRoutes.searchName);
 */

/// Navigate with Dynamic Parameters
// AppRouter.instance.go(AppRoutes.detailsName,pathParameters: {'id': '123'});
