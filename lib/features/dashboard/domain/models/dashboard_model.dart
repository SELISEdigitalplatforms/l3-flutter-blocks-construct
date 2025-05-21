class DashboardModel {
  final String msg;

  const DashboardModel({required this.msg});

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    msg: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}