class UserModel{
final String username;
final  String password;

  UserModel({required this.username, required this.password});

Map<String,dynamic> tojson(){
return {'username':username,password:'password'};

}

}