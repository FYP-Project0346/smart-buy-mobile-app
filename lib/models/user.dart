class UserFields{
  String id = "id";
  String firstname = "firstname";
  String lastname = "lastname";
  String email = "email";
  String token = "token";
}

class User{
  String id;
  String fullname;
  String email;
  String token;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.token,
});

  factory User.fromMap(Map data){
    var f = UserFields();
    return User(id: data[f.id], fullname: "${data[f.firstname]} ${data[f.lastname]}", email: data[f.email], token: data[f.token]);
  }
}