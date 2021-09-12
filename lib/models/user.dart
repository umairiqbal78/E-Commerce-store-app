class UserUid {
  final String uid;

  UserUid({required this.uid});
}

class UserData {
  final String? uid;
  final String? name;
  final String? sugars;
  final int? strength;

  UserData({required this.uid, this.name, this.sugars, this.strength});
}
