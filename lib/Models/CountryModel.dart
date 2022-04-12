class Country {
  String? code;
  String? name;
  String? capital;
  String? native;
  String? phone;
  String? currency;
  String? emoji;
  List<Languages>? languages;

  Country(
      {this.code,
        this.name,
        this.capital,
        this.native,
        this.phone,
        this.currency,
        this.emoji,
        this.languages});

  Country.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    capital = json['capital'];
    native = json['native'];
    phone = json['phone'];
    currency = json['currency'];
    emoji = json['emoji'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['capital'] = this.capital;
    data['native'] = this.native;
    data['phone'] = this.phone;
    data['currency'] = this.currency;
    data['emoji'] = this.emoji;
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Languages {
  String? name;
  String? code;

  Languages({this.name, this.code});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
