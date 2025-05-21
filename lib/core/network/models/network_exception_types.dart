enum NetworkExceptionTypes {
  invalidRefreshToken('invalid_refresh_token'),
  termAndConditionAcceptanceRequire("term_and_condition_acceptance_require"),
  twoFactorCodeRequire("two_factor_code_require"),
  incorrectUserNameOrPassword("incorrect_user_name_or_password"),
  sessionLockId("Session_Lock_Id"),
  personaRequire("persona_require"),
  verificationCodeRequire("verification_code_require"),
  invalidRequest("invalid_request"),
  siteIsNotRegistered("site_is_not_registered"),
  invalidGrant("invalid_grant"),
  other("other");

  final String value;

  const NetworkExceptionTypes(this.value);

  static NetworkExceptionTypes fromString(String value) {
    switch (value) {
      case "invalid_refresh_token":
        return NetworkExceptionTypes.invalidRefreshToken;
      case "term_and_condition_acceptance_require":
        return NetworkExceptionTypes.termAndConditionAcceptanceRequire;
      case "two_factor_code_require":
        return NetworkExceptionTypes.twoFactorCodeRequire;
      case "incorrect_user_name_or_password":
        return NetworkExceptionTypes.incorrectUserNameOrPassword;
      case "Session_Lock_Id":
        return NetworkExceptionTypes.sessionLockId;
      case "persona_require":
        return NetworkExceptionTypes.personaRequire;
      case "verification_code_require":
        return NetworkExceptionTypes.verificationCodeRequire;
      case "invalid_request":
        return NetworkExceptionTypes.invalidRequest;
      case "site_is_not_registered":
        return NetworkExceptionTypes.siteIsNotRegistered;
      case "invalid_grant":
        return NetworkExceptionTypes.invalidGrant;
      default:
        return NetworkExceptionTypes.other;
    }
  }
}
