import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/logic/game_state_model.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/widgets/facedown_playing_card.dart';
import 'package:riverpod_template/src/widgets/faceup_playing_card.dart';

class ColumnCardStack extends ConsumerWidget {
  const ColumnCardStack(
    this.columnIndex, {
    this.cardSize,
    Key? key,
    required this.cards,
  }) : super(key: key);

  final int columnIndex;
  final List<SolitaireCard> cards;
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
        if (incomingCardData['source'] == 'column') {
          final int incomingCardsColumnIndex = incomingCardData['columnIndex'];
          if (incomingCardsColumnIndex == columnIndex) {
            return false;
          }
        }
        final List<SolitaireCard> incomingCards = incomingCardData['cards'];
        if (incomingCards.isEmpty) {
          return false;
        }
        if (cards.isEmpty) {
          if (incomingCards.first.rank == Rank.king) {
            return true;
          } else {
            return false;
          }
        }
        final firstCardIncoming = incomingCards.first;
        final lastCard = cards.last;
        if (firstCardIncoming.color == lastCard.color) {
          return false;
        }
        if (firstCardIncoming.rank == Rank.king ||
            // TODO: May have to change this for the target decks if this widget is used.
            firstCardIncoming.rank == Rank.ace) {
          return false;
        }
        if (lastCard.rank.index != firstCardIncoming.rank.index + 1) {
          return false;
        }
        return true;
      },
      onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
        final int? indexFrom = details.data['columnIndex'];
        final List<SolitaireCard> cards = details.data['cards'];

        ref.read(gameStateModelProvider.notifier).attachCards(
              columnIndexFrom: indexFrom,
              columnIndexTo: columnIndex,
              cardsToAttach: cards,
            );
      },
      builder: (context, candidateData, rejectedData) {
        if (cards.isEmpty) {
          return SizedBox.fromSize(
            size: cardSize,
          );
        }
        return Stack(
          children: cards.map(
            (SolitaireCard card) {
              int index = cards.indexOf(card);
              const double faceDownSpacing = 4.0;
              const double faceUpSpacing = 20.0;
              double translation = 0.0;
              for (int i = 0; i < index; i++) {
                if (cards[i].faceUp) {
                  translation += faceUpSpacing;
                }
                translation += faceDownSpacing;
              }
              final totalCardsInStack = [
                card,
                // TODO: Review this method of adding the attached cards
                for (final card in cards.skip(index + 1))
                  if (card.faceUp) card,
              ];
              return Transform(
                transform: Matrix4.identity()..translate(0.0, translation, 0.0),
                child: SizedBox.fromSize(
                  size: cardSize,
                  child: card.faceUp
                      ? Draggable<Map<String, dynamic>>(
                          child: FaceupPlayingCard(card),
                          feedback: SizedBox.fromSize(
                            size: cardSize,
                            child: ColumnCardStack(
                              columnIndex,
                              cards: totalCardsInStack,
                            ),
                          ),
                          childWhenDragging: FaceupPlayingCard(card),
                          data: {
                            'source': 'column',
                            'columnIndex': columnIndex,
                            'cards': totalCardsInStack,
                          },
                        )
                      : FacedownPlayingCard(size: cardSize),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
