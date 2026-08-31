import 'dart:async';

class User {
  int id;
  String name;
  String? email;

  User(this.id, this.name, this.email);
}

Future<User?> getUserData() async {
  await Future.delayed(Duration(seconds: 2));
  User user = User(
    1,
    "Meet",
    null,
  );

  return user;
}

void main() async {
  print("Fetching user data...");

  try {
    User? user = await getUserData();

    if (user == null) {
      print("No user data found.");
    } else {
      print("User data found!");

      print("ID: ${user.id}");
      print("Name: ${user.name}");

      if (user.email == null) {
        print("Email: Email not available");
      } else {
        print("Email: ${user.email}");
      }
    }
  } catch (e) {
    print("Something went wrong.");
    print("Error: $e");
  }
}