class druglist {
  final String drugId;
  final String patientCode;
  final String drugProcode;
  final String drugName;
  final String drugStart;
  final String drugEnd;
  final String drugMode;
  final String drugIndication;
  final String drugDescription;
  final String drugTime1;
  final String drugTime2;
  final String drugTime3;
  final String drugTime4;
  final String drugTime5;
  final String drugTimeother;
  final String drugDose;
  final String drugUnitdose;
  final String drugOrder;
  final String drugNote1;
  final String drugNote2;
  final String drugNote3;
  final String drugNote4;
  final String drugComments;
  final String drugAlert;

  druglist({
    this.drugId,
    this.patientCode,
    this.drugProcode,
    this.drugName,
    this.drugStart,
    this.drugEnd,
    this.drugMode,
    this.drugIndication,
    this.drugDescription,
    this.drugTime1,
    this.drugTime2,
    this.drugTime3,
    this.drugTime4,
    this.drugTime5,
    this.drugTimeother,
    this.drugDose,
    this.drugUnitdose,
    this.drugOrder,
    this.drugNote1,
    this.drugNote2,
    this.drugNote3,
    this.drugNote4,
    this.drugComments,
    this.drugAlert,

  });

  factory druglist.fromJson(Map<String, dynamic> json){
    return new druglist(
      drugId: json['mdc_id'],
      patientCode: json['mdc_patientcode'],
      drugProcode: json['mdc_procode'],
      drugName: json['mdc_drugname'],
      drugMode: json['mdc_mode'],
      drugStart: json['mdc_start'],
      drugEnd: json['mdc_end'],
      drugIndication: json['mdc_properties'],
      drugDescription: json['mdc_howdrugs'],
      drugTime1: json['mdc_time1'],
      drugTime2: json['mdc_time2'],
      drugTime3: json['mdc_time3'],
      drugTime4: json['mdc_time4'],
      drugTime5: json['mdc_time5'],
      drugTimeother: json['mdc_timeother'],
      drugDose: json['mdc_dose'],
      drugUnitdose: json['mdc_unitdose'],
      drugOrder: json['mdc_order'],
      drugNote1: json['mdc_note1'],
      drugNote2: json['mdc_note2'],
      drugNote3: json['mdc_note3'],
      drugNote4: json['mdc_note4'],
      drugComments: json['mdc_comments'],
      drugAlert: json['mdc_timealert'],
    );
  }
}
