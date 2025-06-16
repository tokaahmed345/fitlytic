class ExcersiceModel {
  String? exerciseId;
  String? name;
  String? gifUrl;
  List<String>? instructions;
  List<String>? targetMuscles;
  List<String>? bodyParts;
  List<String>? equipments;
  List<String>? secondaryMuscles;

  ExcersiceModel(
      {this.exerciseId,
      this.name,
      this.gifUrl,
      this.instructions,
      this.targetMuscles,
      this.bodyParts,
      this.equipments,
      this.secondaryMuscles});

  ExcersiceModel.fromJson(Map<String, dynamic> json) {
    exerciseId = json['exerciseId'];
    name = json['name'];
    gifUrl = json['gifUrl'];
    instructions = json['instructions'].cast<String>();
    targetMuscles = json['targetMuscles'].cast<String>();
    bodyParts = json['bodyParts'].cast<String>();
    equipments = json['equipments'].cast<String>();
    secondaryMuscles = json['secondaryMuscles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exerciseId'] = exerciseId;
    data['name'] = name;
    data['gifUrl'] = gifUrl;
    data['instructions'] = instructions;
    data['targetMuscles'] = targetMuscles;
    data['bodyParts'] = bodyParts;
    data['equipments'] = equipments;
    data['secondaryMuscles'] = secondaryMuscles;
    return data;
  }
}
