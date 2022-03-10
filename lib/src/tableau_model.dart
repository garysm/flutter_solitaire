import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';
import 'package:riverpod_template/src/model/tableau.dart';
import 'package:riverpod_template/src/model/target_deck.dart';

const int columnCount = 7;

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
        _tempDeck.add(
          SolitaireCard(suit: suit, rank: rank, faceUp: false, inStock: false),
        );
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
    state = state.copyWith(
      stockCards: _tempDeck
          .map(
            (card) => card.copyWith(
              faceUp: true,
              inStock: true,
            ),
          )
          .toList(),
    );
  }

  void attachCardsToColumn({
    /// The index that the cards originate from
    /// If this is null, the cards originate from the stock
    required int? columnIndexFrom,
    required int columnIndexTo,
    required List<SolitaireCard> cardsToAttach,
  }) {
    final List<SolitaireCard>? sourceColumn =
        (columnIndexFrom == null) ? null : state.mainColumns[columnIndexFrom];
    final List<SolitaireCard> targetColumn = state.mainColumns[columnIndexTo];
    targetColumn.addAll(cardsToAttach);
    if (columnIndexFrom != null) {
      sourceColumn!.removeWhere((card) => cardsToAttach.contains(card));
      if (sourceColumn.isNotEmpty) {
        sourceColumn.last = sourceColumn.last.copyWith(faceUp: true);
      }
      state = state.copyWith(
        mainColumns: List.from(state.mainColumns)
          ..[columnIndexFrom] = sourceColumn
          ..[columnIndexTo] = targetColumn,
      );
    } else {
      state = state.copyWith(
        wasteCards: state.wasteCards
          ..removeWhere((card) => cardsToAttach.contains(card)),
        mainColumns: List.from(state.mainColumns)
          ..[columnIndexTo] = targetColumn,
      );
    }
  }

  void addToTargetDeck({
    required int? columnIndexFrom,
    required Suit targetSuit,
    required SolitaireCard cardToAdd,
  }) {
    List<SolitaireCard>? sourceColumn =
        (columnIndexFrom == null) ? null : state.mainColumns[columnIndexFrom];

    if (columnIndexFrom != null) {
      sourceColumn!.removeWhere((card) => cardToAdd == card);
      if (sourceColumn.isNotEmpty) {
        sourceColumn.last = sourceColumn.last.copyWith(faceUp: true);
      }

      state = state.copyWith(
          mainColumns: List.from(state.mainColumns)
            ..[columnIndexFrom] = sourceColumn);
    } else {
      state = state.copyWith(
        wasteCards: state.wasteCards..removeWhere((card) => cardToAdd == card),
      );
    }
    switch (targetSuit) {
      case Suit.diamonds:
        state = state.copyWith(
          diamondTarget: state.diamondTarget.copyWith(
            cards: [
              ...state.diamondTarget.cards,
              cardToAdd,
            ],
          ),
        );
        break;
      case Suit.hearts:
        state = state.copyWith(
          heartsTarget: state.heartsTarget.copyWith(
            cards: [
              ...state.heartsTarget.cards,
              cardToAdd,
            ],
          ),
        );
        break;
      case Suit.spades:
        state = state.copyWith(
          spadesTarget: state.spadesTarget.copyWith(
            cards: [
              ...state.spadesTarget.cards,
              cardToAdd,
            ],
          ),
        );
        break;
      case Suit.clubs:
        state = state.copyWith(
          clubsTarget: state.clubsTarget.copyWith(
            cards: [
              ...state.clubsTarget.cards,
              cardToAdd,
            ],
          ),
        );
        break;
    }
  }

  void drawNextFromStock() {
    if (state.stockCards.isNotEmpty) {
      // Move the card to the waste pile, then remove it from the stock pile
      // The last waste card is not removed every time, as it will be reset when the stock is empty
      final nextStockCard = state.stockCards.first;
      state = state.copyWith(
        wasteCards: state.wasteCards..add(nextStockCard),
        stockCards: state.stockCards..remove(nextStockCard),
      );
    }
  }

  void resetStock() {
    if (state.wasteCards.isNotEmpty) {
      state = state.copyWith(
        stockCards: state.wasteCards,
        wasteCards: [],
      );
    }
  }
}
