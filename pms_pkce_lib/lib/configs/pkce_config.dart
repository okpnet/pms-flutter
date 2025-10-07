class PkceConfig {
  final String clientId;
  final String challengeMethod; // e.g. "S256"
  final List<String> scopes;

  const PkceConfig({
    required this.clientId,
    this.challengeMethod = 'S256',
    this.scopes = const ['openid', 'profile', 'email', 'offline_access'],
  });

  Map<String, String> get additionalParameters => {
    'code_challenge_method': challengeMethod,
  };

  Map<String, dynamic> toMap()=>{
    'clientId':clientId,
    'challengeMethod':challengeMethod,
    'scopes':scopes
  };

  static PkceConfig fromMap(Map<String, dynamic> map) =>PkceConfig(
    clientId: map['clientId'] as String,
    challengeMethod: map['challengeMethod'] as String,
    scopes: List<String>.from(map['scopes'])
    );
}