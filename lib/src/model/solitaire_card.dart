import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'solitaire_card.freezed.dart';

@freezed
class SolitaireCard with _$SolitaireCard {
  const SolitaireCard._();
  factory SolitaireCard({
    required Suit suit,
    required Rank rank,
    required bool faceUp,
  }) = _SolitaireCard;

  Widget getIcon({double size = 30.0}) {
    switch (suit) {
      case Suit.hearts:
        return Icon(RpgAwesome.hearts, size: size, color: Colors.red);
      case Suit.diamonds:
        return Icon(RpgAwesome.diamonds, size: size, color: Colors.red);
      case Suit.clubs:
        return Icon(RpgAwesome.clovers, size: size, color: Colors.black);
      case Suit.spades:
        return Icon(RpgAwesome.spades, size: size, color: Colors.black);
    }
  }

  String get rankText {
    switch (rank) {
      case Rank.ace:
        return 'A';
      case Rank.two:
        return '2';
      case Rank.three:
        return '3';
      case Rank.four:
        return '4';
      case Rank.five:
        return '5';
      case Rank.six:
        return '6';
      case Rank.seven:
        return '7';
      case Rank.eight:
        return '8';
      case Rank.nine:
        return '9';
      case Rank.ten:
        return '10';
      case Rank.jack:
        return 'J';
      case Rank.queen:
        return 'Q';
      case Rank.king:
        return 'K';
    }
  }
}

enum CardColor {
  black,
  red,
}

enum Suit { hearts, diamonds, clubs, spades }

enum Rank {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
}
