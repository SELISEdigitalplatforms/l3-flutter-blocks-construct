class MoreModel {
  final String msg;

  const MoreModel({required this.msg});

  factory MoreModel.fromJson(Map<String, dynamic> json) => MoreModel(
    msg: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}