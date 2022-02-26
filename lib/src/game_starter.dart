import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/model/game_data.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/model/tableau.dart';
import 'package:riverpod_template/src/model/target_deck.dart';

const int columnCount = 7;

final gameStateModelProvider = StateNotifierProvider<GameStateModel, GameData>(
  (ref) => GameStateModel(),
);

class GameStateModel extends StateNotifier<GameData> {
  GameStateModel() : super(const GameData.init()) {
    _init();
  }

  late List<SolitaireCard> _tempDeck;
  late List<List<SolitaireCard>> _mainColumnsCards;

  _init() {
    _generateTempDeck();
    _distributeCards();

    final Tableau startingTableau = Tableau(
      stockCards: [..._tempDeck],
      wasteCards: [],
      mainColumnsCards: _mainColumnsCards,
      diamondTarget: TargetDeck(
        Suit.diamonds,
        cards: [],
      ),
      heartsTarget: TargetDeck(
        Suit.hearts,
        cards: [],
      ),
      spadesTarget: TargetDeck(
        Suit.spades,
        cards: [],
      ),
      clubsTarget: TargetDeck(
        Suit.clubs,
        cards: [],
      ),
    );

    state = GameData.ready(startingTableau);
  }

  void _generateTempDeck() {
    _tempDeck = [];

    for (Suit suit in Suit.values) {
      for (Rank rank in Rank.values) {
        _tempDeck.add(SolitaireCard(suit: suit, rank: rank, faceUp: false));
      }
    }
  }

  void _distributeCards() {
    _mainColumnsCards = [];
    Random random = Random();
    for (int i = 0; i < columnCount; i++) {
      _mainColumnsCards.add([]);
      for (int j = 0; j < i + 1; j++) {
        final randomCardPicked = _tempDeck.removeAt(
          random.nextInt(_tempDeck.length),
        );
        _mainColumnsCards[i].add(
          randomCardPicked,
        );
      }
    }
  }
}
