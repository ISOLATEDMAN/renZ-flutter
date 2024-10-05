class Usermodel {
  final String id;
  final String name;
  final String email;
  final String password;

  const Usermodel({
    required this.id,
  required this.name,
  required this.email,
  required this.password});

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'email':email,
      'password':password

    };
  }

  factory Usermodel.fromMap(Map<String,dynamic>map){
    return Usermodel(id: map['id']??' ', 
    name: map['name']??' ', 
    email: map['email']??' ',
     password: map['password']??' ');
  }


}


// class Usermodel {
//   final String id;
//   final String name;
//   final String email;
//   final String password;

//   const Usermodel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.password,
//   });

//   // Convert to a Map (useful for saving to MongoDB)
//   Map<String, dynamic> toMap() {
//     return {
//       '_id': id, // MongoDB uses _id for the ID field
//       'name': name,
//       'email': email,
//       'password': password,
//     };
//   }

//   // Convert to JSON (can be used for sending JSON data)
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'password': password, // Normally, you won't send passwords as plain text
//     };
//   }

//   // Create a Usermodel object from a Map (from MongoDB or any other source)
//   factory Usermodel.fromMap(Map<String, dynamic> map) {
//     return Usermodel(
//       id: map['_id'] ?? '', // MongoDB uses _id
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       password: map['password'] ?? '',
//     );
//   }

//   // Create a Usermodel object from JSON (useful for receiving JSON data)
//   factory Usermodel.fromJson(Map<String, dynamic> json) {
//     return Usermodel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       password: json['password'] ?? '',
//     );
//   }
// }
