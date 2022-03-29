import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/logic/tableau_model.dart';
import 'package:riverpod_template/src/model/game_state.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/model/tableau.dart';

final _tableauProvider =
    StateNotifierProvider<TableauModel, Tableau>((ref) => TableauModel());

final gameStateModelProvider = StateNotifierProvider<GameStateModel, GameState>(
  (ref) => GameStateModel(ref.watch(_tableauProvider), ref.read),
);

class GameStateModel extends StateNotifier<GameState> {
  GameStateModel(this._tableau, this._read) : super(const GameState.init()) {
    _init();
  }

  final Reader _read;
  final Tableau _tableau;

  int get totalCardsCount {
    return _tableau.mainColumns
            .map((column) => column.length)
            .reduce((a, b) => a + b) +
        _tableau.stockCards.length +
        _tableau.wasteCards.length +
        _tableau.diamondTarget.cards.length +
        _tableau.heartsTarget.cards.length +
        _tableau.spadesTarget.cards.length +
        _tableau.clubsTarget.cards.length;
  }

  int get targetCardsCount {
    return _tableau.diamondTarget.cards.length +
        _tableau.heartsTarget.cards.length +
        _tableau.spadesTarget.cards.length +
        _tableau.clubsTarget.cards.length;
  }

  String get totalCardsCountString {
    return '${_tableau.mainColumns.map((c) => c.length).reduce((a, b) => a + b) + _tableau.stockCards.length + _tableau.wasteCards.length + _tableau.diamondTarget.cards.length + _tableau.heartsTarget.cards.length + _tableau.spadesTarget.cards.length + _tableau.clubsTarget.cards.length}';
  }

  void restart() {
    _init();
  }

  _init() {
    state = GameState.ready(_tableau);
  }

  void attachCards({
    required int? columnIndexFrom,
    required int columnIndexTo,
    required List<SolitaireCard> cardsToAttach,
  }) {
    _read(_tableauProvider.notifier).attachCardsToColumn(
      columnIndexFrom: columnIndexFrom,
      columnIndexTo: columnIndexTo,
      cardsToAttach: cardsToAttach,
    );
  }

  void addToTargetDeck({
    required int? columnIndexFrom,
    required Suit targetSuit,
    required SolitaireCard cardToAdd,
  }) {
    _read(_tableauProvider.notifier).addToTargetDeck(
      columnIndexFrom: columnIndexFrom,
      targetSuit: targetSuit,
      cardToAdd: cardToAdd,
    );
  }

  void drawNextFromStock() {
    // Ensure that there is a card to draw
    _read(_tableauProvider.notifier).drawNextFromStock();
  }

  void resetStock() {
    _read(_tableauProvider.notifier).resetStock();
  }
}
