// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'solitaire_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SolitaireCardTearOff {
  const _$SolitaireCardTearOff();

  _SolitaireCard call(
      {required Suit suit,
      required Rank rank,
      required bool faceUp,
      bool? inStock}) {
    return _SolitaireCard(
      suit: suit,
      rank: rank,
      faceUp: faceUp,
      inStock: inStock,
    );
  }
}

/// @nodoc
const $SolitaireCard = _$SolitaireCardTearOff();

/// @nodoc
mixin _$SolitaireCard {
  Suit get suit => throw _privateConstructorUsedError;
  Rank get rank => throw _privateConstructorUsedError;
  bool get faceUp => throw _privateConstructorUsedError;
  bool? get inStock => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SolitaireCardCopyWith<SolitaireCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolitaireCardCopyWith<$Res> {
  factory $SolitaireCardCopyWith(
          SolitaireCard value, $Res Function(SolitaireCard) then) =
      _$SolitaireCardCopyWithImpl<$Res>;
  $Res call({Suit suit, Rank rank, bool faceUp, bool? inStock});
}

/// @nodoc
class _$SolitaireCardCopyWithImpl<$Res>
    implements $SolitaireCardCopyWith<$Res> {
  _$SolitaireCardCopyWithImpl(this._value, this._then);

  final SolitaireCard _value;
  // ignore: unused_field
  final $Res Function(SolitaireCard) _then;

  @override
  $Res call({
    Object? suit = freezed,
    Object? rank = freezed,
    Object? faceUp = freezed,
    Object? inStock = freezed,
  }) {
    return _then(_value.copyWith(
      suit: suit == freezed
          ? _value.suit
          : suit // ignore: cast_nullable_to_non_nullable
              as Suit,
      rank: rank == freezed
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as Rank,
      faceUp: faceUp == freezed
          ? _value.faceUp
          : faceUp // ignore: cast_nullable_to_non_nullable
              as bool,
      inStock: inStock == freezed
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$SolitaireCardCopyWith<$Res>
    implements $SolitaireCardCopyWith<$Res> {
  factory _$SolitaireCardCopyWith(
          _SolitaireCard value, $Res Function(_SolitaireCard) then) =
      __$SolitaireCardCopyWithImpl<$Res>;
  @override
  $Res call({Suit suit, Rank rank, bool faceUp, bool? inStock});
}

/// @nodoc
class __$SolitaireCardCopyWithImpl<$Res>
    extends _$SolitaireCardCopyWithImpl<$Res>
    implements _$SolitaireCardCopyWith<$Res> {
  __$SolitaireCardCopyWithImpl(
      _SolitaireCard _value, $Res Function(_SolitaireCard) _then)
      : super(_value, (v) => _then(v as _SolitaireCard));

  @override
  _SolitaireCard get _value => super._value as _SolitaireCard;

  @override
  $Res call({
    Object? suit = freezed,
    Object? rank = freezed,
    Object? faceUp = freezed,
    Object? inStock = freezed,
  }) {
    return _then(_SolitaireCard(
      suit: suit == freezed
          ? _value.suit
          : suit // ignore: cast_nullable_to_non_nullable
              as Suit,
      rank: rank == freezed
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as Rank,
      faceUp: faceUp == freezed
          ? _value.faceUp
          : faceUp // ignore: cast_nullable_to_non_nullable
              as bool,
      inStock: inStock == freezed
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_SolitaireCard extends _SolitaireCard with DiagnosticableTreeMixin {
  _$_SolitaireCard(
      {required this.suit,
      required this.rank,
      required this.faceUp,
      this.inStock})
      : super._();

  @override
  final Suit suit;
  @override
  final Rank rank;
  @override
  final bool faceUp;
  @override
  final bool? inStock;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SolitaireCard(suit: $suit, rank: $rank, faceUp: $faceUp, inStock: $inStock)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SolitaireCard'))
      ..add(DiagnosticsProperty('suit', suit))
      ..add(DiagnosticsProperty('rank', rank))
      ..add(DiagnosticsProperty('faceUp', faceUp))
      ..add(DiagnosticsProperty('inStock', inStock));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SolitaireCard &&
            const DeepCollectionEquality().equals(other.suit, suit) &&
            const DeepCollectionEquality().equals(other.rank, rank) &&
            const DeepCollectionEquality().equals(other.faceUp, faceUp) &&
            const DeepCollectionEquality().equals(other.inStock, inStock));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(suit),
      const DeepCollectionEquality().hash(rank),
      const DeepCollectionEquality().hash(faceUp),
      const DeepCollectionEquality().hash(inStock));

  @JsonKey(ignore: true)
  @override
  _$SolitaireCardCopyWith<_SolitaireCard> get copyWith =>
      __$SolitaireCardCopyWithImpl<_SolitaireCard>(this, _$identity);
}

abstract class _SolitaireCard extends SolitaireCard {
  factory _SolitaireCard(
      {required Suit suit,
      required Rank rank,
      required bool faceUp,
      bool? inStock}) = _$_SolitaireCard;
  _SolitaireCard._() : super._();

  @override
  Suit get suit;
  @override
  Rank get rank;
  @override
  bool get faceUp;
  @override
  bool? get inStock;
  @override
  @JsonKey(ignore: true)
  _$SolitaireCardCopyWith<_SolitaireCard> get copyWith =>
      throw _privateConstructorUsedError;
}
