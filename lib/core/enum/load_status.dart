/// 데이터 조회 진행 상태
enum LoadStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == loading;
}
