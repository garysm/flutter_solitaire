import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/model/game_state.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/model/tableau.dart';
import 'package:riverpod_template/src/model/target_deck.dart';

const int columnCount = 7;

final _tableauProvider =
    StateNotifierProvider<TableauModel, Tableau>((ref) => TableauModel());

class TableauModel extends StateNotifier<Tableau> {
  TableauModel()
      : super(
          Tableau(
            stockCards: [],
            wasteCards: [],
            mainColumns: [],
            diamondTarget: TargetDeck(Suit.diamonds, cards: []),
            heartsTarget: TargetDeck(Suit.hearts, cards: []),
            spadesTarget: TargetDeck(Suit.spades, cards: []),
            clubsTarget: TargetDeck(Suit.clubs, cards: []),
          ),
        ) {
    _init();
  }

  late List<SolitaireCard> _tempDeck;

  void _init() {
    _generateTempDeck();
    _fillDeck(_tempDeck);
    _addRemainder();
  }

  void _generateTempDeck() {
    _tempDeck = [];
    for (Suit suit in Suit.values) {
      for (Rank rank in Rank.values) {
        _tempDeck.add(SolitaireCard(suit: suit, rank: rank, faceUp: false));
      }
    }
  }

  void _addColumn() {
    state = state.copyWith(
      mainColumns: [
        ...state.mainColumns,
        [],
      ],
    );
  }

  void _addCardToColumn(int columnIndex, SolitaireCard card) {
    state = state.copyWith(
      mainColumns: List.from(state.mainColumns)..[columnIndex].add(card),
    );
  }

  void _fillDeck(List<SolitaireCard> tempDeck) {
    Random random = Random();
    for (int i = 0; i < columnCount; i++) {
      _addColumn();
      for (int j = 0; j < i + 1; j++) {
        SolitaireCard randomCardPicked = tempDeck.removeAt(
          random.nextInt(tempDeck.length),
        );
        if (j == i) {
          randomCardPicked = randomCardPicked.copyWith(faceUp: true);
        }
        _addCardToColumn(i, randomCardPicked);
      }
    }
  }

  void _addRemainder() {
    state = state.copyWith(stockCards: _tempDeck);
  }
}

final gameStateModelProvider = StateNotifierProvider<GameStateModel, GameState>(
  (ref) => GameStateModel(ref.watch(_tableauProvider), ref.read),
);

class GameStateModel extends StateNotifier<GameState> {
  GameStateModel(this._tableau, this._read) : super(const GameState.init()) {
    _init();
  }

  final Tableau _tableau;
  final Reader _read;

  String get totalCardsCount =>
      '${_tableau.mainColumns.map((c) => c.length).reduce((a, b) => a + b) + _tableau.stockCards.length + _tableau.wasteCards.length}';

  _init() {
    state = GameState.ready(_tableau);
  }
}
