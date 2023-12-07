class VANumbers {
  String? bank;
  String? vaNumber;

  VANumbers({this.bank, this.vaNumber});

  VANumbers.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    vaNumber = json['va_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank'] = bank;
    data['va_number'] = vaNumber;
    return data;
  }
}
