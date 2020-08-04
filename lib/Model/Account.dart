class Account {
  int id;
  String name;
  String email;
  String password;
  String image;

  Account(this.id, this.name, this.email, this.password, this.image);

  Map<String, dynamic> tomap() {
    Map map = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'image': image
    };
    return map;
  }
}
