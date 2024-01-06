import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    // ignore: invalid_annotation_target
    @JsonKey(name: "_id") String? id,
    String? title,
    String? description,
    // ignore: invalid_annotation_target
    @JsonKey(name: "is_completed") bool? isCompleted,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}
