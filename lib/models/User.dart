class User {
  final String id;
  final String email;
  final String password;
  final String fullName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int giftpoints;
  final int nbTrashThrown;
  final String? smartBinId;
  final String role;
  final bool isBanned;
  final String? profileImage;
  final String userCode;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    this.createdAt,
    this.updatedAt,
    required this.giftpoints,
    required this.nbTrashThrown,
    this.smartBinId,
    required this.role,
    required this.isBanned,
    this.profileImage,
    required this.userCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),  // Ensure the ID is a string
      email: json['email'] ?? '',  // Default to an empty string if no email
      password: json['password'] ?? '',  // Default to an empty string if no password
      fullName: json['full_name'] ?? '',  // Default to an empty string if no full name
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      giftpoints: json['giftpoints'] ?? 0,  // Default to 0 if no giftpoints
      nbTrashThrown: json['nb_trashthrown'] ?? 0,  // Default to 0 if no trash thrown count
      smartBinId: json['smart_bin_id'] as String?,  // Allow null if no smartBinId
      role: json['role'] ?? '',  // Default to an empty string if no role
      isBanned: json['isbanned'] == 1,  // Convert 1 or 0 to a boolean value
      profileImage: json['profile_image'] as String?,  // Allow null if no profile image
      userCode: json['user_code'] ?? '',  // Default to an empty string if no user code
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'full_name': fullName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'giftpoints': giftpoints,
      'nb_trashthrown': nbTrashThrown,
      'smart_bin_id': smartBinId,
      'role': role,
      'isbanned': isBanned ? 1 : 0,  // Convert the boolean to 1 or 0 for the backend
      'profile_image': profileImage,
      'user_code': userCode,
    };
  }
}
