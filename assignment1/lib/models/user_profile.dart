class UserProfile {
  String name;
  String email;
  String phone;
  String address;
  String avatarUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.avatarUrl,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? avatarUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
