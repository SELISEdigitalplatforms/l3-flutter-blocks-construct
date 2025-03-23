class SplashModel {
  final String msg;

  const SplashModel({required this.msg});

  factory SplashModel.fromJson(Map<String, dynamic> json) => SplashModel(
    msg: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}