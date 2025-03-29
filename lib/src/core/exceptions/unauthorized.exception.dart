class UnauthorizedException implements Exception {
  final String _message =
      'Email ou senha incorretos, verifique e tente novamente';

  @override
  String toString() {
    return _message;
  }
}
