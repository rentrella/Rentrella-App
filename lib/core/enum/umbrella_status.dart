enum UmbrellaStatus {
  ready(value: 'AVAILABLE'), //대여 가능
  rentingByMe(value: 'RENTING_BY_ME'), //나의 대여
  rented(value: 'RENTED'), //다른 유저의 대여
  overdue(value: 'OVERDUE'), //다른 유저의 연체
  overdueByMe(value: 'OVERDUE_BY_ME'), //나의 연체
  unavailable(value: 'UNAVAILABLE'), //대여 불가능
  broken(value: 'BROKEN'); //고장

  final String value;

  const UmbrellaStatus({required this.value});
}
