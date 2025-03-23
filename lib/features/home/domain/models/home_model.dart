class HomeModel {
  final String msg;

  const HomeModel({required this.msg});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    msg: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}