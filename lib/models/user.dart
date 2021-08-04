class MyUser {
  String? uId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? bio;
  String? profileImg;
  String? message_token;

  MyUser(
      {this.uId,
      this.message_token,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.bio,
      this.profileImg});

  MyUser.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    message_token = json['message_token'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    bio = json['bio'];
    profileImg = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uId'] = this.uId;
    data['message_token'] = this.message_token;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['bio'] = this.bio;
    data['profile_img'] = this.profileImg;
    return data;
  }
}
