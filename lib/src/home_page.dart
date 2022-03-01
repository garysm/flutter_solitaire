import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/game_state_model.dart';
import 'package:riverpod_template/src/model/game_state.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/model/tableau.dart';
import 'package:riverpod_template/src/model/target_deck.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameState gameData = ref.watch(gameStateModelProvider);
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: SafeArea(
        child: gameData.maybeWhen(
          ready: (Tableau tableau) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: const [
                                Expanded(
                                  child: StockStack(),
                                ),
                              ],
                            ),
                          ),
                          TargetDecks(tableau),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Expanded(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final column in tableau.mainColumns)
                            Expanded(
                              child: CardStack(
                                  tableau.mainColumns.indexOf(column),
                                  cards: column),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text('Stock: ${tableau.stockCards.length}'),
                      Text('Waste: ${tableau.wasteCards.length}'),
                      Text(
                          'Total: ${ref.watch(gameStateModelProvider.notifier).totalCardsCount}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          orElse: () => const SizedBox(),
        ),
      ),
    );
  }
}

class CardStack extends StatelessWidget {
  const CardStack(
    this.columnIndex, {
    Key? key,
    required this.cards,
  }) : super(key: key);

  final int columnIndex;
  final List<SolitaireCard> cards;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: cards.map(
        (SolitaireCard card) {
          int index = cards.indexOf(card);
          const double distance = 5.0;
          double translation = (index * (distance));
          if (index > 0 && cards.elementAt(index - 1).faceUp) {
            translation = translation * 6.5;
          }
          return Transform(
            transform: Matrix4.identity()..translate(0.0, translation, 0.0),
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: card.faceUp
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        final totalCardsInStack = [
                          card,
                          // TODO: Review this method of adding the attached cards
                          for (final card in cards.skip(index + 1))
                            if (card.faceUp) card,
                        ];
                        return Draggable<Map>(
                          child: FaceupPlayingCard(card),
                          feedback: SizedBox(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            child: CardStack(
                              columnIndex,
                              cards: totalCardsInStack,
                            ),
                          ),
                          childWhenDragging: FaceupPlayingCard(card),
                          data: {
                            'columnIndex': columnIndex,
                            'cards': totalCardsInStack,
                          },
                        );
                      },
                    )
                  : const FacedownPlayingCard(),
            ),
          );
        },
      ).toList(),
    );
  }
}

class TargetDecks extends StatelessWidget {
  const TargetDecks(
    this.tableau, {
    Key? key,
  }) : super(key: key);

  final Tableau tableau;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TargetDeckStack(tableau.diamondTarget),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TargetDeckStack(tableau.heartsTarget),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TargetDeckStack(tableau.spadesTarget),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TargetDeckStack(tableau.clubsTarget),
            ),
          ),
        ],
      ),
    );
  }
}

class FaceupPlayingCard extends StatelessWidget {
  const FaceupPlayingCard(
    this.card, {
    Key? key,
  }) : super(key: key);

  final SolitaireCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Center(
              child: card.getIcon(size: 50.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                card.rankText,
                style: TextStyle(
                  color: card.color,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.topRight,
              child: card.getIcon(),
            ),
          ),
        ],
      ),
    );
  }
}

class FacedownPlayingCard extends StatelessWidget {
  const FacedownPlayingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.blue.shade900,
        border: Border.all(color: Colors.black),
      ),
      // TODO add better resizing for shine
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(right: 20.0),
          width: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class StockStack extends StatelessWidget {
  const StockStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        color: Colors.green.shade700,
      ),
    );
  }
}

class TargetDeckStack extends StatelessWidget {
  const TargetDeckStack(this.targetDeck, {Key? key}) : super(key: key);

  final TargetDeck targetDeck;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        color: Colors.green.shade700,
        child: targetDeck.getIcon(),
      ),
    );
  }
}
