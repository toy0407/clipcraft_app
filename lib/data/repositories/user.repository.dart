class UserRepository {
  UserRepository._internal();
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;

  Future<Map<String, dynamic>?> getUserDetails() async {
    // TODO: Implement user details fetching logic
    return null;
  }

  Future<bool> createUser({required String name}) async {
    return true;
  }
}
