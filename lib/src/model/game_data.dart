import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_template/src/model/tableau.dart';

part 'game_data.freezed.dart';

@freezed
class GameData with _$GameData {
  const factory GameData.init() = _Init;
  const factory GameData.ready(Tableau tableau) = _Ready;
  const factory GameData.loading() = _Loading;
  const factory GameData.error(String error) = _Error;
}
