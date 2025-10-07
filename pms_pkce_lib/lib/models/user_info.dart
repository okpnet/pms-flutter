class UserInfo {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;

  UserInfo({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'username': this.username,
    };
  }
}
