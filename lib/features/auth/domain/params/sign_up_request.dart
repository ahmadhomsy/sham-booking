class SignUpRequest {

  const SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
  });
  final String password;
  final String name;
  final String email;
}
