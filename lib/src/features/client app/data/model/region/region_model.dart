class BaseViewModel {
  // افترض أن هناك بعض المتغيرات مثل id، name، إلخ
  final int id;
  final String name;

  BaseViewModel({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory BaseViewModel.fromJson(Map<String, dynamic> json) {
    return BaseViewModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
