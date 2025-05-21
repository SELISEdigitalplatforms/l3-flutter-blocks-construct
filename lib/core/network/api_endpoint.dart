class ApiEndpoint {
  /// Returns the path for an user/profile [endpoint].
  static String user(UserEndpoint endpoint, {String? playerProfileId}) {
    const path = '/api/v1';
    switch (endpoint) {
      case UserEndpoint.createUserProfile:
        return '$path/user_account/create';
      case UserEndpoint.getUserProfile:
        if (playerProfileId == null) {
          throw ArgumentError('player profileId is required');
        }
        return '$path/player';
    }
  }

  static String test(TestEndpoint endpoint) {
    switch (endpoint) {
      case TestEndpoint.test:
        return 'Use your relevant endpoint path';
    }
  }

  static String auth(AuthEndpoint endpoint) {
    const path = '/authentication/v1/oauth';
    switch (endpoint) {
      case AuthEndpoint.login:
        return '$path/token';
    }
  }
}

/// A collection of endpoints used for authentication purposes.
enum TestEndpoint { test }

enum UserEndpoint {
  createUserProfile,
  getUserProfile,
}

enum AuthEndpoint { login }
