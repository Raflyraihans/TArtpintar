import 'package:rtkita/app/data/warga.dart';

class Statistik {
  int? countPeople;
  int? countFamilyCard;
  int? countMan;
  int? countWoman;
  int? homeActive;
  int? homeUnactive;
  StatisticDebit? statisticDebit;
  StatisticDebit? statisticCredit;
  int? creditMonth;
  LastMonth? lastMonth;
  int? progressBar;
  JumlahProgresIpl? jumlahProgresIpl;
  List<Aktifitas>? aktifitas;

  Statistik(
      {this.countPeople,
      this.countFamilyCard,
      this.countMan,
      this.countWoman,
      this.homeActive,
      this.homeUnactive,
      this.statisticDebit,
      this.statisticCredit,
      this.creditMonth,
      this.lastMonth,
      this.progressBar,
      this.jumlahProgresIpl,
      this.aktifitas});

  Statistik.fromJson(Map<String, dynamic> json) {
    countPeople = json['count_people'];
    countFamilyCard = json['count_family_card'];
    countMan = json['count_man'];
    countWoman = json['count_woman'];
    homeActive = json['home_active'];
    homeUnactive = json['home_unactive'];
    statisticDebit = json['statistic_debit'] != null
        ? StatisticDebit.fromJson(json['statistic_debit'])
        : null;
    statisticCredit = json['statistic_credit'] != null
        ? StatisticDebit.fromJson(json['statistic_credit'])
        : null;
    creditMonth = json['credit_month'];
    lastMonth = json['last_month'] != null
        ? LastMonth.fromJson(json['last_month'])
        : null;
    progressBar = json['progress_bar'];
    jumlahProgresIpl = json['jumlah_progres_ipl'] != null
        ? JumlahProgresIpl.fromJson(json['jumlah_progres_ipl'])
        : null;
    if (json['aktifitas'] != null) {
      aktifitas = <Aktifitas>[];
      json['aktifitas'].forEach((v) {
        aktifitas!.add(Aktifitas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count_people'] = countPeople;
    data['count_family_card'] = countFamilyCard;
    data['count_man'] = countMan;
    data['count_woman'] = countWoman;
    data['home_active'] = homeActive;
    data['home_unactive'] = homeUnactive;
    if (statisticDebit != null) {
      data['statistic_debit'] = statisticDebit!.toJson();
    }
    if (statisticCredit != null) {
      data['statistic_credit'] = statisticCredit!.toJson();
    }
    data['credit_month'] = creditMonth;
    if (lastMonth != null) {
      data['last_month'] = lastMonth!.toJson();
    }
    data['progress_bar'] = progressBar;
    data['jumlah_progres_ipl'] = jumlahProgresIpl;
    if (aktifitas != null) {
      data['aktifitas'] = aktifitas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatisticDebit {
  int? januari;
  int? februari;
  int? maret;
  int? april;
  int? mei;
  int? juni;
  int? juli;
  int? agustus;
  int? september;
  int? oktober;
  int? november;
  int? desember;

  StatisticDebit(
      {this.januari,
      this.februari,
      this.maret,
      this.april,
      this.mei,
      this.juni,
      this.juli,
      this.agustus,
      this.september,
      this.oktober,
      this.november,
      this.desember});

  StatisticDebit.fromJson(Map<String, dynamic> json) {
    januari = json['januari'];
    februari = json['februari'];
    maret = json['maret'];
    april = json['april'];
    mei = json['mei'];
    juni = json['juni'];
    juli = json['juli'];
    agustus = json['agustus'];
    september = json['september'];
    oktober = json['oktober'];
    november = json['november'];
    desember = json['desember'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['januari'] = januari;
    data['februari'] = februari;
    data['maret'] = maret;
    data['april'] = april;
    data['mei'] = mei;
    data['juni'] = juni;
    data['juli'] = juli;
    data['agustus'] = agustus;
    data['september'] = september;
    data['oktober'] = oktober;
    data['november'] = november;
    data['desember'] = desember;
    return data;
  }
}

class LastMonth {
  String? totalSaldo;
  String? date;

  LastMonth({this.totalSaldo, this.date});

  LastMonth.fromJson(Map<String, dynamic> json) {
    totalSaldo = json['total_saldo'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_saldo'] = totalSaldo;
    data['date'] = date;
    return data;
  }
}

class Aktifitas {
  int? id;
  int? rukunTetanggaId;
  int? userId;
  String? description;
  String? createdAt;
  String? updatedAt;
  User? user;

  Aktifitas(
      {this.id,
      this.rukunTetanggaId,
      this.userId,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.user});

  Aktifitas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rukunTetanggaId = json['rukun_tetangga_id'];
    userId = json['user_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rukun_tetangga_id'] = rukunTetanggaId;
    data['user_id'] = userId;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class JumlahProgresIpl {
  int? paid;
  int? unpaid;
  int? total;

  JumlahProgresIpl({this.paid, this.unpaid, this.total});

  JumlahProgresIpl.fromJson(Map<String, dynamic> json) {
    paid = json['paid'];
    unpaid = json['unpaid'];
    total = json['total'];
  }
}
