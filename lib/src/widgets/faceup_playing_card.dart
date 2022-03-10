import 'package:flutter/material.dart';
import 'package:riverpod_template/src/model/solitaire_card.dart';

class FaceupPlayingCard extends StatelessWidget {
  const FaceupPlayingCard(
    this.card, {
    this.size,
    Key? key,
  }) : super(key: key);

  final SolitaireCard card;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?.width,
      height: size?.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Center(
              child: card.getIcon(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2.0),
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
          Align(
            alignment: Alignment.topRight,
            child: card.getIcon(size: (size?.width ?? 30.0)),
          ),
        ],
      ),
    );
  }
}
