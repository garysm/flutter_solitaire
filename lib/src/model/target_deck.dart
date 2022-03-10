import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';

part 'target_deck.freezed.dart';

@freezed
class TargetDeck with _$TargetDeck {
  const TargetDeck._();
  factory TargetDeck(
    Suit suit, {
    required List<SolitaireCard> cards,
  }) = _TargetDeck;

  Widget getIcon({double size = 50.0}) {
    switch (suit) {
      case Suit.hearts:
        return Icon(RpgAwesome.hearts,
            size: size, color: Colors.green.shade700);
      case Suit.diamonds:
        return Icon(RpgAwesome.diamonds,
            size: size, color: Colors.green.shade700);
      case Suit.clubs:
        return Icon(RpgAwesome.clovers,
            size: size, color: Colors.green.shade700);
      case Suit.spades:
        return Icon(RpgAwesome.spades,
            size: size, color: Colors.green.shade700);
    }
  }
}
