class ReceiptItemConvertModel {
  final int id;
  final String name;
  final String company;
  final String color;
  final String convertFromBranchName;
  final String? convertToBranchName;
  final String itemBarcode;
  final String? address;
  final int receiptItemConvertStatus;

  ReceiptItemConvertModel({
    required this.id,
    required this.name,
    required this.company,
    required this.color,
    required this.convertFromBranchName,
    required this.convertToBranchName,
    required this.itemBarcode,
    this.address,
    required this.receiptItemConvertStatus,
  });

  factory ReceiptItemConvertModel.fromJson(Map<String, dynamic> json) {
    return ReceiptItemConvertModel(
      id: json['id'] as int,
      name: json['name'] as String,
      company: json['company'] as String,
      color: json['color'] as String,
      convertFromBranchName: json['convertFromBranchName'] as String,
      convertToBranchName: json['convertToBranchName'] as String?,
      itemBarcode: json['itemBarcode'] as String,
      address: json['address'] as String?,
      receiptItemConvertStatus: json['receiptItemConvertStatus'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'company': company,
      'color': color,
      'convertFromBranchName': convertFromBranchName,
      'convertToBranchName': convertToBranchName,
      'itemBarcode': itemBarcode,
      'address': address,
      'receiptItemConvertStatus': receiptItemConvertStatus,
    };
  }
}
