class UserModel {
  String userId;
  String userName;
  String userEmail;
  String userPassword;
  String userAvatar;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userAvatar,
  });

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, userEmail: $userEmail, userPassword: $userPassword)';
  }
}
