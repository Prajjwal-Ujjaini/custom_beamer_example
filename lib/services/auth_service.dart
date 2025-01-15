class AuthService {
  Future<bool> authenticate(String username, String password) async {
    // Simulate API call to authenticate user
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return username == "admin" && password == "password"; // Example logic
  }

  Future<void> logoutFromServer() async {
    // Simulate API call to log out
    await Future.delayed(Duration(seconds: 1));
    // Assume successful logout
  }
}
