import 'dart:convert';

class JobModel {
  int id;
  String name;
  String image;
  String jobTimeType;
  String jobType;
  String jobLevel;
  String jobDescription;
  String jobSkill;
  String compName;
  String compEmail;
  String compWebsite;
  String aboutComp;
  String location;
  String salary;
  int favorites;
  int expired;
  String createdAt;
  String updatedAt;
  JobModel({
    required this.id,
    required this.name,
    required this.image,
    required this.jobTimeType,
    required this.jobType,
    required this.jobLevel,
    required this.jobDescription,
    required this.jobSkill,
    required this.compName,
    required this.compEmail,
    required this.compWebsite,
    required this.aboutComp,
    required this.location,
    required this.salary,
    required this.favorites,
    required this.expired,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'jobTimeType': jobTimeType,
      'jobType': jobType,
      'jobLevel': jobLevel,
      'jobDescription': jobDescription,
      'jobSkill': jobSkill,
      'compName': compName,
      'compEmail': compEmail,
      'compWebsite': compWebsite,
      'aboutComp': aboutComp,
      'location': location,
      'salary': salary,
      'favorites': favorites,
      'expired': expired,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      jobTimeType: map['jobTimeType'] as String,
      jobType: map['jobType'] as String,
      jobLevel: map['jobLevel'] as String,
      jobDescription: map['jobDescription'] as String,
      jobSkill: map['jobSkill'] as String,
      compName: map['compName'] as String,
      compEmail: map['compEmail'] as String,
      compWebsite: map['compWebsite'] as String,
      aboutComp: map['aboutComp'] as String,
      location: map['location'] as String,
      salary: map['salary'] as String,
      favorites: map['favorites'] as int,
      expired: map['expired'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) =>
      JobModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobModel(id: $id, name: $name, image: $image, jobTimeType: $jobTimeType, jobType: $jobType, jobLevel: $jobLevel, jobDescription: $jobDescription, jobSkill: $jobSkill, compName: $compName, compEmail: $compEmail, compWebsite: $compWebsite, aboutComp: $aboutComp, location: $location, salary: $salary, favorites: $favorites, expired: $expired, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
