enum AppRoutes {
  splash('/', 'splash'),
  home('/home', 'home'),
  dashboard('/dashboard', 'dashboard'),
  iam('/iam', 'iam'),
  profile('/profile', 'profile'),
  more('/more', 'more'),
  login('/login', 'login'),
  signUp('/sign-up', 'sign-up'),
  forgotPass('/forgot-pass', 'forgot-pass'),
  emailSent('/email-sent', 'email-sent'),
  editProfile('/edit-profile-screen', 'edit-profile'),
  setupAuth('/setup-auth-screen', 'setup-auth-screen'),
  inventory('/inventory', 'inventory'),
  manageAuth('/manage-auth-screen', 'manage-screen'),
  twoFactorAuth('/two-factor-auth', 'two-factor-auth'),
  changePassword('/change-password', 'change-password'),
  passwordUpdated('/password-updated', 'password-updated'),
  resetPassword('/reset-password', 'reset-password'),
  enableBiometric('/enable-biometric', 'enable-biometric'),
  ;

  final String path;
  final String name;

  const AppRoutes(this.path, this.name);

  static AppRoutes fromPath(String path) {
    return AppRoutes.values.firstWhere((element) => element.path == path);
  }
}

class RouteParam {
  final String previousRoute;

  RouteParam({required this.previousRoute});
}
