import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/logic/game_state_model.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';

class EmptyTargetDeck extends ConsumerWidget {
  const EmptyTargetDeck(this.suit, {this.cardSize, Key? key}) : super(key: key);

  final Suit suit;
  final Size? cardSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (incomingCardData) {
        if (incomingCardData == null) {
          return false;
        }
        if (incomingCardData['source'] == null) {
          return false;
        } else if (incomingCardData['source'] != 'column' &&
            incomingCardData['source'] != 'waste') {
          return false;
        }
        final List<SolitaireCard> incomingCards = incomingCardData['cards'];
        if (incomingCards.length != 1) {
          return false;
        }
        final incomingCard = incomingCards.first;
        if (incomingCard.rank != Rank.ace) {
          return false;
        }
        return incomingCard.suit == suit;
      },
      onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
        final int? indexFrom = details.data['columnIndex'];
        final List<SolitaireCard> incomingCards = details.data['cards'];
        final incomingCard = incomingCards.first;
        ref.read(gameStateModelProvider.notifier).addToTargetDeck(
              columnIndexFrom: indexFrom,
              targetSuit: suit,
              cardToAdd: incomingCard,
            );
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: cardSize?.width,
          height: cardSize?.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.green.shade800,
            border: Border.all(color: Colors.black),
          ),
          child: _getIcon(),
        );
      },
    );
  }

  Widget _getIcon({double size = 50.0}) {
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
