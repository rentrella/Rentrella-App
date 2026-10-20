enum NotificationStatus {
  returned('RETURNED'),
  overdue('OVERDUE'),
  service('SERVICE'),
  inquiry('INQUIRY');

  final String value;

  const NotificationStatus(this.value);
}
