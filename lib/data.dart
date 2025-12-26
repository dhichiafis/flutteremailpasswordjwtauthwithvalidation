class Token {

  final String access_token;
  final String token_type;

  const Token({required this.access_token,required this.token_type});

  factory Token.fromJson(Map<String,dynamic>json){
    return Token(
      access_token: json['access_token'],
      token_type: json['token_type']
    );
  }
}


class User{
  final int id;
  final String email;
  final DateTime created_at;

  const User({required this.id,required this.email,required this.created_at});

  factory User.fromJson(Map<String,dynamic>json){
    return User(
      id: json['id'],
      email:json['email'],
      created_at: DateTime.parse(json['created_at'])
    );
  }
}



class Todo{
  final String title;
  final String description;
  final int id;
  final int user_id;
  final DateTime created_at;

  const Todo({required this.title,required this.description,required this.id,required this.user_id,required this.created_at});

  factory Todo.fromJson(Map<String,dynamic>json){
    return Todo(
      title:json['title'],
      description:json['description'],
      id:json['id'],
      user_id: json['user_id'],
      created_at: DateTime.parse(json['created_at'])
    );
  }
}