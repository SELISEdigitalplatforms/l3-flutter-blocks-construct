class IamModel {
  final String msg;

  const IamModel({required this.msg});

  factory IamModel.fromJson(Map<String, dynamic> json) => IamModel(
    msg: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}