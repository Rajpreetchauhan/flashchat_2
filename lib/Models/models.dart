class Userdata{
  String firstname;
  String lastname;
  String email;

//<editor-fold desc="Data Methods">
  Userdata({
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Userdata &&
          runtimeType == other.runtimeType &&
          firstname == other.firstname &&
          lastname == other.lastname &&
          email == other.email);

  @override
  int get hashCode => firstname.hashCode ^ lastname.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'Userdata{' +
        ' firstname: $firstname,' +
        ' lastname: $lastname,' +
        ' email: $email,' +
        '}';
  }

  Userdata copyWith({
    String? firstname,
    String? lastname,
    String? email,
  }) {
    return Userdata(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': this.firstname,
      'lastname': this.lastname,
      'email': this.email,
    };
  }

  factory Userdata.fromMap(Map<String, dynamic> map) {
    return Userdata(
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
    );
  }

//</editor-fold>
}