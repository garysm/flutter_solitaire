import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_template/src/model/tableau.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState.init() = _Init;
  const factory GameState.ready(Tableau tableau) = _Ready;
  const factory GameState.loading() = _Loading;
  const factory GameState.error(String error) = _Error;
}
