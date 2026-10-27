/// 폼 제출 진행 상태
enum FormStatus {
  initial,
  submitting,
  success,
  failure;

  bool get isSubmitting => this == submitting;
}
