class Organization {
  final int id;
  final String name;
  final String enrollCode;
  final List<dynamic> attSessions;
  final List<dynamic> orgMembers;
  final UserCreator user_creator;

  Organization({
    required this.id,
    required this.name,
    required this.enrollCode,
    required this.attSessions,
    required this.orgMembers,
    required this.user_creator,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      enrollCode: json['enroll_code'],
      attSessions: json['att_sessions'] ?? [],
      orgMembers: json['org_members'] ?? [],
      user_creator: UserCreator.fromJson(json['user_creator']),
    );
  }
}

class UserCreator {
  final int id;
  final String name;
  final String email;

  UserCreator({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserCreator.fromJson(Map<String, dynamic> json) {
    return UserCreator(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
