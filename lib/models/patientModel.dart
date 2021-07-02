class PatientModel {
  final String id;
  final String age;
  final String sex;
  final String location;
  final String status;

  PatientModel({this.id, this.age, this.sex, this.location, this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'age': age,
      'sex': sex,
      'location': location,
      'status': status
    };
  }
}
