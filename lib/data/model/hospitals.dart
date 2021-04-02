class Hospitals {
    List<Hospital> hospitals;

    Hospitals({
        this.hospitals,
    });

    Hospitals.fromJson(Map<String, dynamic> json) {
    if (json['hospitals'] != null) {
      hospitals = [];
      json['hospitals'].forEach((v) {
        hospitals.add(new Hospital.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hospitals != null) {
      data['hospitals'] = this.hospitals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hospital {
    String name;
    String location;
    String tel;
    String gps;
    double distance;

    Hospital({
        this.name,
        this.location,
        this.tel,
        this.gps,
        this.distance = 0.00
    });

    Hospital.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    tel = json['tel'];
    gps = json['gps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    data['tel'] = this.tel;
    data['gps'] = this.gps;
    return data;
  }
}
