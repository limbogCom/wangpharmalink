class Patientdata{
  final String patientID;
  final String patientCode;
  final String patientTitlename;
  final String patientFirstname;
  final String patientLastname;

  Patientdata({
    this.patientID,
    this.patientCode,
    this.patientTitlename,
    this.patientFirstname,
    this.patientLastname,

  });

  factory Patientdata .fromJson(Map<String, dynamic> json){
    return new Patientdata(
      patientID: json['patient_id'],
      patientCode: json['patient_code'],
      patientTitlename: json['pti_titlename'],
      patientFirstname: json['pti_firstname'],
      patientLastname: json['pti_;astname'],
    );
  }
}
