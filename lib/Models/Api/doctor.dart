class Doctor {
  int? id;
  String? doctorName;
  String? doctorEmail;
  String? phoneNumber;
  String? doctorImageURL;
  Address? address;

  Doctor(
      {this.id,
        this.doctorName,
        this.doctorEmail,
        this.phoneNumber,
        this.doctorImageURL,
        this.address});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorName = json['doctorName'];
    doctorEmail = json['doctorEmail'];
    phoneNumber = json['phoneNumber'];
    doctorImageURL = json['doctorImageURL'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorName'] = this.doctorName;
    data['doctorEmail'] = this.doctorEmail;
    data['phoneNumber'] = this.phoneNumber;
    data['doctorImageURL'] = this.doctorImageURL;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? latitude;
  String? longitude;
  String? country;
  String? city;

  Address({this.latitude, this.longitude, this.country, this.city});

  Address.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['country'] = this.country;
    data['city'] = this.city;
    return data;
  }
}