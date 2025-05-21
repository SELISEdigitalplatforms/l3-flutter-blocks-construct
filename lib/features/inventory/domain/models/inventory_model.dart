class InventoryModel {
  final String msg;

  const InventoryModel({required this.msg});

  factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
        msg: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
