import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/game_starter.dart';
import 'package:riverpod_template/src/model/game_data.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/model/tableau.dart';
import 'package:riverpod_template/src/model/target_deck.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameData gameData = ref.watch(gameStateModelProvider);
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: SafeArea(
        child: gameData.maybeWhen(
          ready: (Tableau tableau) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
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
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TargetDeckStack(tableau.diamondTarget),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TargetDeckStack(tableau.heartsTarget),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TargetDeckStack(tableau.spadesTarget),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TargetDeckStack(tableau.clubsTarget),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final column in tableau.mainColumnsCards)
                        Expanded(
                          child: Column(
                            children: [
                              for (final card in column) PlayingCard(card),
                            ],
                          ),
                        ),
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

class PlayingCard extends StatelessWidget {
  const PlayingCard(
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
                style: const TextStyle(
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
