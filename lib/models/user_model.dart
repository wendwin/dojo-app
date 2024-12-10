class User {
  final int id;
  final String email;
  final String name;
  final String role;
  final List<OrganizationMember>? orgMembers;
  final List<Organization>? organizations;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.orgMembers,
    this.organizations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      orgMembers: (json['org_members'] as List<dynamic>?)
          ?.map((member) => OrganizationMember.fromJson(member))
          .toList(),
      organizations: (json['organizations'] as List<dynamic>?)
          ?.map((org) => Organization.fromJson(org))
          .toList(),
    );
  }
}

class OrganizationMember {
  final String email;
  final String name;
  final String role;

  OrganizationMember({
    required this.email,
    required this.name,
    required this.role,
  });

  factory OrganizationMember.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return OrganizationMember(
      email: user['email'],
      name: user['name'],
      role: user['role'],
    );
  }
}

class Organization {
  final int id;
  final String name;
  final String enrollCode;
  final List<OrganizationMember>? members;

  Organization({
    required this.id,
    required this.name,
    required this.enrollCode,
    this.members,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      enrollCode: json['enroll_code'],
      members: (json['member'] as List<dynamic>?)
          ?.map((member) => OrganizationMember.fromJson(member))
          .toList(),
    );
  }
}
