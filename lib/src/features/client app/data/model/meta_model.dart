
import '../../domain/entities/meta_entity.dart';

class MetaModel extends MetaEntity {
  const MetaModel({
    required int pages,
    required int page,
    required int perPage,
    required int total,
  }) : super(
    pages: pages,
    page: page,
    perPage: perPage,
    total: total,
  );

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      pages: json['pages'] as int,
      page: json['page'] as int,
      perPage: json['perpage'] as int,
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pages': pages,
      'page': page,
      'perpage': perPage,
      'total': total,
    };
  }
}