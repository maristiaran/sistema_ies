import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/utils/datetime.dart';

IESUser fromJsonToIESUser(Map<String, dynamic> json, dynamic id) {
  return IESUser(
      id: id,
      firstname: json['firstname'],
      surname: json['surname'],
      dni: json['dni'],
      birthdate: stringToDate(json['birthdate']),
      email: json['email']);
}

Map<String, dynamic> fromIESUserToJson(IESUser iesUser) {
  return {
    'firstname': iesUser.firstname,
    'surname': iesUser.surname,
    'dni': iesUser.dni,
    'email': iesUser.email,
    'birthdate': dateToString(iesUser.birthdate)
  };
}
