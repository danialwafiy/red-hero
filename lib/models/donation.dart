
class Donation {

  final String hospital, date, donorName,donorDonatedLitre;
  final int id,donorID;

  Donation({
    this.id,
    this.hospital,
    this.date,
    this.donorName,
    this.donorDonatedLitre,
    this.donorID
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      hospital: json['hospital'],
      date: json['date'],
      donorName: json['donor_name'],
      donorDonatedLitre: json['donor_donated_litre'],
      donorID: json['donor_id']
    );
  }

}


