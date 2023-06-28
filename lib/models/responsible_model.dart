class ResponsibleModel {
  ResponsibleModel(
      {this.idResponsible = '',
      this.idPatient = '',
      required this.name,
      required this.surname,
      required this.cpf,
      this.phone = '',
      this.isDelete = false,
      this.isEdit = false});

  final String idPatient;
  final String idResponsible;
  String name;
  String surname;
  String cpf;
  String phone;
  bool isDelete;
  bool isEdit;

  @override
  String toString() {
    return 'idPatient: $idPatient, idResponsible: $idResponsible, name: $name, surname: $surname, cpf: $cpf, phone: $phone, isDelete: $isDelete, isEdit: $isEdit,';
  }

  factory ResponsibleModel.fromJson(Map<String, dynamic> json) {
    return ResponsibleModel(
      idPatient: json['id_patient'] ?? '',
      idResponsible: json['id_responsible'] ?? '',
      surname: json['surname'] ?? '',
      cpf: json['cpf'] ?? '',
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
