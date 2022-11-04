final now = DateTime.now();

class User {
  String? firstName;
  String? lastName;
  String? password;
  String? email;
  String? phone;
  String? name;
  DateTime? birthday;

  User({
    this.firstName,
    this.lastName,
    this.password,
    this.email,
    this.phone,
    this.name,
    this.birthday,
  });

  @override
  String toString() {
    return 'User{name: $name,firstName: $firstName, lastName: $lastName,'
        'password: $password, email: $email,'
        'phone: $phone,birthDate: $birthday}';
  }

  User.fromMap(Map<String, dynamic> user)
      : firstName = user['firstName'] as String,
        lastName = user['lastName'] as String,
        password = user['password'] as String,
        email = user['email'] as String,
        phone = user['phone'].toString(),
        birthday = DateTime.parse(user['birthDate']),
        name = user['name'] as String;

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        name = json['name'],
        email = json['email'],
        birthday = DateTime.parse(json['birthDate']),
        phone = json['phone'],
        lastName = json['lastName'],
        password = json['password'];

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'email': email,
      'phone': phone,
      'birthDate': birthday.toString(),
      'name': name,
    };
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'name': name,
        'email': email,
        'birthDate': birthday.toString(),
        'phone': phone,
        'lastName': lastName,
        'password': password,
      };
}
