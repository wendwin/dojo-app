class Organization {
  final int id;
  final String name;
  final String enrollCode;
  final List<dynamic> attendanceSessions;
  final List<Member> members;
  final UserCreator createdBy;

  Organization({
    required this.id,
    required this.name,
    required this.enrollCode,
    required this.attendanceSessions,
    required this.members,
    required this.createdBy,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      enrollCode: json['enroll_code'],
      attendanceSessions: json['attendance_sessions'] ?? [],
      members: (json['member'] as List<dynamic>?)
              ?.map((m) => Member.fromJson(m))
              .toList() ??
          [],
      createdBy: UserCreator.fromJson(json['created_by']),
    );
  }
}

class Member {
  final User user;

  Member({
    required this.user,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String name;
  final String email;
  final String role;

  User({
    required this.name,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}

class UserCreator {
  final String name;
  final String email;
  final String role;

  UserCreator({
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserCreator.fromJson(Map<String, dynamic> json) {
    return UserCreator(
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
