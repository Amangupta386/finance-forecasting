/// A class representing login information.
class LoginModel {
  final int id;
  final String username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String token;

  /// Constructor for creating a [LoginModel] instance.
  LoginModel(  { this.firstName, this.lastName, this.gender, this.image,required this.token,required this.id,required this.username,  this.email});

  /// Factory method to create a [LoginModel] instance from JSON data.
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id:json['id'],
      username: json['username'],
      token: json['token'],
    );
  }

  // /// Convert the [LoginModel] to a JSON representation.
  // Map<String, dynamic> toJson() {
  //   return {
  //     'username': username,
  //     'password': password,
  //   };
  // }
}
