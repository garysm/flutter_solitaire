import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';

part 'target_deck.freezed.dart';

@freezed
class TargetDeck with _$TargetDeck {
  factory TargetDeck(
    Suit suit, {
    required List<SolitaireCard> cards,
  }) = _TargetDeck;
}
