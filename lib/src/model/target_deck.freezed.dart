// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'target_deck.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TargetDeckTearOff {
  const _$TargetDeckTearOff();

  _TargetDeck call(Suit suit, {required List<SolitaireCard> cards}) {
    return _TargetDeck(
      suit,
      cards: cards,
    );
  }
}

/// @nodoc
const $TargetDeck = _$TargetDeckTearOff();

/// @nodoc
mixin _$TargetDeck {
  Suit get suit => throw _privateConstructorUsedError;
  List<SolitaireCard> get cards => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TargetDeckCopyWith<TargetDeck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetDeckCopyWith<$Res> {
  factory $TargetDeckCopyWith(
          TargetDeck value, $Res Function(TargetDeck) then) =
      _$TargetDeckCopyWithImpl<$Res>;
  $Res call({Suit suit, List<SolitaireCard> cards});
}

/// @nodoc
class _$TargetDeckCopyWithImpl<$Res> implements $TargetDeckCopyWith<$Res> {
  _$TargetDeckCopyWithImpl(this._value, this._then);

  final TargetDeck _value;
  // ignore: unused_field
  final $Res Function(TargetDeck) _then;

  @override
  $Res call({
    Object? suit = freezed,
    Object? cards = freezed,
  }) {
    return _then(_value.copyWith(
      suit: suit == freezed
          ? _value.suit
          : suit // ignore: cast_nullable_to_non_nullable
              as Suit,
      cards: cards == freezed
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<SolitaireCard>,
    ));
  }
}

/// @nodoc
abstract class _$TargetDeckCopyWith<$Res> implements $TargetDeckCopyWith<$Res> {
  factory _$TargetDeckCopyWith(
          _TargetDeck value, $Res Function(_TargetDeck) then) =
      __$TargetDeckCopyWithImpl<$Res>;
  @override
  $Res call({Suit suit, List<SolitaireCard> cards});
}

/// @nodoc
class __$TargetDeckCopyWithImpl<$Res> extends _$TargetDeckCopyWithImpl<$Res>
    implements _$TargetDeckCopyWith<$Res> {
  __$TargetDeckCopyWithImpl(
      _TargetDeck _value, $Res Function(_TargetDeck) _then)
      : super(_value, (v) => _then(v as _TargetDeck));

  @override
  _TargetDeck get _value => super._value as _TargetDeck;

  @override
  $Res call({
    Object? suit = freezed,
    Object? cards = freezed,
  }) {
    return _then(_TargetDeck(
      suit == freezed
          ? _value.suit
          : suit // ignore: cast_nullable_to_non_nullable
              as Suit,
      cards: cards == freezed
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<SolitaireCard>,
    ));
  }
}

/// @nodoc

class _$_TargetDeck extends _TargetDeck with DiagnosticableTreeMixin {
  _$_TargetDeck(this.suit, {required this.cards}) : super._();

  @override
  final Suit suit;
  @override
  final List<SolitaireCard> cards;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TargetDeck(suit: $suit, cards: $cards)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TargetDeck'))
      ..add(DiagnosticsProperty('suit', suit))
      ..add(DiagnosticsProperty('cards', cards));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TargetDeck &&
            const DeepCollectionEquality().equals(other.suit, suit) &&
            const DeepCollectionEquality().equals(other.cards, cards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(suit),
      const DeepCollectionEquality().hash(cards));

  @JsonKey(ignore: true)
  @override
  _$TargetDeckCopyWith<_TargetDeck> get copyWith =>
      __$TargetDeckCopyWithImpl<_TargetDeck>(this, _$identity);
}

abstract class _TargetDeck extends TargetDeck {
  factory _TargetDeck(Suit suit, {required List<SolitaireCard> cards}) =
      _$_TargetDeck;
  _TargetDeck._() : super._();

  @override
  Suit get suit;
  @override
  List<SolitaireCard> get cards;
  @override
  @JsonKey(ignore: true)
  _$TargetDeckCopyWith<_TargetDeck> get copyWith =>
      throw _privateConstructorUsedError;
}
