
class StudentModel  {
   int? id;

  final String name;
  final String image;
  final String mobile;
  final String age;

  StudentModel({required this.name,required this.age,this.id,required this.image,required this.mobile});

  static StudentModel fromMap(Map<String, Object?>map){
    final id=map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final mobile =map['mobile'] as String;
    final image = map['image'] as String;

    return StudentModel(id:id, name: name, age: age,mobile: mobile,image: image);
  }
}