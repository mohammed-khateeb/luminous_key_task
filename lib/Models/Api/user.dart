class User {
  String? firstName;
  String? email;
  String? password;
  String? mobileNumber;

  int? id;

  User(
      {
      this.firstName,
        this.id,
      this.email,this.password,this.mobileNumber});

  User.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    firstName = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];

    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['name'] = firstName;
    data['email'] = email;
    data['id'] = id;
    data['mobile_number'] = mobileNumber;

    return data;
  }
}


