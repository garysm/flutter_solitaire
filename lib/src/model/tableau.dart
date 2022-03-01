import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/model/target_deck.dart';

part 'tableau.freezed.dart';

@freezed
class Tableau with _$Tableau {
  factory Tableau({
    required List<SolitaireCard> stockCards,
    required List<SolitaireCard> wasteCards,
    required List<List<SolitaireCard>> mainColumns,
    required TargetDeck diamondTarget,
    required TargetDeck heartsTarget,
    required TargetDeck spadesTarget,
    required TargetDeck clubsTarget,
  }) = _Tableau;
}
