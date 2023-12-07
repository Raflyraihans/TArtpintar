import 'package:rtkita/app/data/family_card.dart';

class Invoice {
  int? id;
  int? houseId;
  int? invoiceIplId;
  String? status;
  String? createdAt;
  String? updatedAt;
  InvoiceIpl? invoiceIpl;
  House? house;

  Invoice(
      {this.id,
      this.houseId,
      this.invoiceIplId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.invoiceIpl,
      this.house});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    houseId = json['house_id'];
    invoiceIplId = json['invoice_ipl_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoiceIpl = json['invoice_ipl'] != null
        ? InvoiceIpl.fromJson(json['invoice_ipl'])
        : null;
    house = json['house'] != null ? House.fromJson(json['house']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['house_id'] = houseId;
    data['invoice_ipl_id'] = invoiceIplId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (invoiceIpl != null) {
      data['invoice_ipl'] = invoiceIpl!.toJson();
    }
    if (house != null) {
      data['house'] = house!.toJson();
    }
    return data;
  }
}

class InvoiceIpl {
  int? id;
  int? rukunTetanggaId;
  String? date;
  int? manual;
  String? createdAt;
  String? updatedAt;

  InvoiceIpl(
      {this.id,
      this.rukunTetanggaId,
      this.date,
      this.manual,
      this.createdAt,
      this.updatedAt});

  InvoiceIpl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rukunTetanggaId = json['rukun_tetangga_id'];
    date = json['date'];
    manual = json['manual'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rukun_tetangga_id'] = rukunTetanggaId;
    data['date'] = date;
    data['manual'] = manual;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
