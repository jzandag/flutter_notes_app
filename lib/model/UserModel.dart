class UserModel {
  final String? uid;

  UserModel({this.uid});

  @override
  String toString() {
    return uid ?? 'null';
  }
}
