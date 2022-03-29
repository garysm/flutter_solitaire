import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/logic/game_state_model.dart';
import 'package:riverpod_template/src/model/game_state.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/model/tableau.dart';
import 'package:riverpod_template/src/widgets/column_card_stack.dart';
import 'package:riverpod_template/src/widgets/empty_target_deck.dart';
import 'package:riverpod_template/src/widgets/facedown_playing_card.dart';
import 'package:riverpod_template/src/widgets/faceup_playing_card.dart';
import 'package:riverpod_template/src/widgets/target_deck_stack.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameState gameData = ref.watch(gameStateModelProvider);
    const double padding = 5.0;

    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: SafeArea(
        child: gameData.maybeWhen(
          ready: (Tableau tableau) {
            if (tableau.diamondTarget.cards.length +
                    tableau.spadesTarget.cards.length +
                    tableau.heartsTarget.cards.length +
                    tableau.clubsTarget.cards.length ==
                52) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You Win!",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text("Start Over"),
                      onPressed: () {
                        ref.read(gameStateModelProvider.notifier).restart();
                      },
                    ),
                  ],
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  // The padding is subtracted from the width.
                  final cardSize = Size((width / 7), width / 5);
                  return Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: cardSize.width * 7,
                            height: cardSize.height,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: cardSize.width * 4,
                                  child: _targetDecks(tableau, cardSize),
                                ),
                                _stockCards(tableau, cardSize, ref.read),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Expanded(
                            flex: 2,
                            child: _mainColumns(tableau, constraints, cardSize),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: _gameInfoWidget(tableau),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          orElse: () => const SizedBox(),
        ),
      ),
    );
  }

  Row _targetDecks(Tableau tableau, Size cardSize) {
    return Row(
      children: [
        tableau.diamondTarget.cards.isEmpty
            ? EmptyTargetDeck(
                Suit.diamonds,
                cardSize: cardSize,
              )
            : SizedBox.fromSize(
                size: cardSize,
                child: TargetDeckStack(
                  Suit.diamonds,
                  cards: tableau.diamondTarget.cards,
                ),
              ),
        tableau.spadesTarget.cards.isEmpty
            ? EmptyTargetDeck(
                Suit.spades,
                cardSize: cardSize,
              )
            : SizedBox.fromSize(
                size: cardSize,
                child: TargetDeckStack(
                  Suit.spades,
                  cards: tableau.spadesTarget.cards,
                ),
              ),
        tableau.heartsTarget.cards.isEmpty
            ? EmptyTargetDeck(
                Suit.hearts,
                cardSize: cardSize,
              )
            : SizedBox.fromSize(
                size: cardSize,
                child: TargetDeckStack(
                  Suit.hearts,
                  cards: tableau.heartsTarget.cards,
                ),
              ),
        tableau.clubsTarget.cards.isEmpty
            ? EmptyTargetDeck(
                Suit.clubs,
                cardSize: cardSize,
              )
            : SizedBox.fromSize(
                size: cardSize,
                child: TargetDeckStack(
                  Suit.clubs,
                  cards: tableau.clubsTarget.cards,
                ),
              ),
      ],
    );
  }

  Row _stockCards(Tableau tableau, Size cardSize, Reader read) {
    return Row(
      children: [
        if (tableau.wasteCards.isNotEmpty)
          SizedBox.fromSize(
            size: cardSize,
            child: Draggable<Map<String, dynamic>>(
              child: FaceupPlayingCard(tableau.wasteCards.last),
              feedback: SizedBox.fromSize(
                size: cardSize,
                child: FaceupPlayingCard(tableau.wasteCards.last),
              ),
              childWhenDragging: FaceupPlayingCard(tableau.wasteCards.last),
              data: {
                'source': 'waste',
                'cards': [tableau.wasteCards.last],
              },
            ),
          ),
        (tableau.stockCards.isNotEmpty)
            ? GestureDetector(
                onTap: () =>
                    read(gameStateModelProvider.notifier).drawNextFromStock(),
                child: FacedownPlayingCard(
                  size: cardSize,
                  hasStripe: false,
                ),
              )
            : SizedBox.fromSize(
                size: cardSize,
                child: GestureDetector(
                  onTap: () =>
                      read(gameStateModelProvider.notifier).resetStock(),
                ),
              ),
      ],
    );
  }

  Row _mainColumns(Tableau tableau, BoxConstraints constraints, Size cardSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final column in tableau.mainColumns)

          /// The CardStack is wrapped in a SizedBox to extend the
          /// target area in which to drag the cards to the bottom of the screen.
          SizedBox(
            height: constraints.maxHeight,
            child: ColumnCardStack(
              tableau.mainColumns.indexOf(column),
              cards: column,
              cardSize: cardSize,
            ),
          ),
      ],
    );
  }

  Widget _gameInfoWidget(Tableau tableau) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Stock: ${tableau.stockCards.length}'),
            Text('Waste: ${tableau.wasteCards.length}'),
            Text(
                'Total: ${ref.watch(gameStateModelProvider.notifier).totalCardsCountString}'),
          ],
        );
      },
    );
  }
}
