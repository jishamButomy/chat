class RegisterModel {
  String? username;
  String? email;
  String? password;
  int? otp;

  RegisterModel({this.username, this.email, this.password, this.otp});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['otp'] = otp;
    return data;
  }
}
