import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_template/src/game_starter.dart';
import 'package:riverpod_template/src/model/game_data.dart';
import 'package:riverpod_template/src/model/tableau.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameData gameData = ref.watch(gameStateModelProvider);
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: SafeArea(
        child: gameData.maybeWhen(
          ready: (Tableau tableau) => SizedBox(
            child: Row(
              children: [
                for (final column in tableau.mainColumnsCards)
                  Expanded(
                    child: Column(
                      children: [
                        for (final card in column)
                          Container(
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
