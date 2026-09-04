enum SecurityLevel {
  low('LOW', '약함'),
  middle('MIDDLE', '중간'),
  high('HIGH', '높음');

  final String value;
  final String label;

  const SecurityLevel(this.value, this.label);
}
