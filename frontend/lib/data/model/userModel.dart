class Person {
  final int id;
  final String pname;
  final String pphone;
  final int pAge;

  Person({required this.id, required this.pname, required this.pphone, required this.pAge});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      pname: json['pname'],
      pphone: json['pphone'],
      pAge: json['pAge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pname': pname,
      'pphone': pphone,
      'pAge': pAge,
    };
  }
}
