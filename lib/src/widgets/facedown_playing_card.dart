import 'package:flutter/material.dart';

class FacedownPlayingCard extends StatelessWidget {
  const FacedownPlayingCard({
    this.size,
    this.hasStripe = true,
    Key? key,
  }) : super(key: key);

  const FacedownPlayingCard.withoutStripe({
    this.size,
    this.hasStripe = false,
    Key? key,
  }) : super(key: key);

  final Size? size;
  final bool? hasStripe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?.width,
      height: size?.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.blue.shade900,
        border: Border.all(color: Colors.black),
      ),
      // TODO add better resizing for shine
      child: (hasStripe ?? true)
          ? Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(
                    right: (size?.width) != null ? (size!.width * 0.2) : 5.0),
                width: (size?.width) != null ? (size!.width * 0.2) : 5.0,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
