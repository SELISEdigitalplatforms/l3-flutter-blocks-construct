enum GrantTypes {
  password('password'),
  refreshToken('refresh_token'),
  authenticateSite('authenticate_site');

  final String value;

  const GrantTypes(this.value);
}
