class User {
  String id = "";
  String email = "";
  String name = "";
  String mobile = "";
  String profilePic = "";
  String token = "";
  bool isPending;
  User(res, {
    required this.id,
    required this.email,
    required this.name,
    required this.mobile,
    required this.profilePic,
    required this.token,
    required this.isPending,
  });
}
