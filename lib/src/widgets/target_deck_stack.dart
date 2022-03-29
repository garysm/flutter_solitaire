import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/logic/game_state_model.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/widgets/faceup_playing_card.dart';

class TargetDeckStack extends ConsumerWidget {
  const TargetDeckStack(this.suit, {required this.cards, Key? key})
      : super(key: key);

  final Suit suit;

  final List<SolitaireCard> cards;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (incomingCardData) {
        if (incomingCardData == null) {
          return false;
        }
        final List<SolitaireCard> incomingCards = incomingCardData['cards'];
        if (incomingCards.isEmpty) {
          return false;
        }
        if (incomingCards.length > 1) {
          return false;
        }
        final incomingCard = incomingCards.first;
        if (incomingCard.rank.index != cards.last.rank.index + 1) {
          return false;
        }
        return incomingCard.suit == suit;
      },
      onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
        final indexFrom = details.data['columnIndex'];

        final List<SolitaireCard> cards = details.data['cards'];
        final SolitaireCard card = cards.first;
        ref.read(gameStateModelProvider.notifier).addToTargetDeck(
              columnIndexFrom: indexFrom,
              targetSuit: suit,
              cardToAdd: card,
            );
      },
      builder: (context, candidateData, rejectedData) {
        return FaceupPlayingCard(cards.last);
      },
    );
  }
}
