class Student{
  int id;
  String name;
  int age;

  Student({this.id, this.name, this.age});

  factory Student.fromMap(Map<String, dynamic> json) => new Student(
    id: json["id"],
    name: json["name"],
    age: json["age"],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'age': age,
  };
}