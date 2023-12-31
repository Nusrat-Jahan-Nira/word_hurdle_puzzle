import 'package:flutter/material.dart';
import 'package:word_hurdle_puzzle/virtual_key.dart';

const keysList = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M']
];

class KeyboardView extends StatelessWidget {
  final List<String> excludedLetters;
  final Function(String) onPressed;

  const KeyboardView({
    super.key,
    required this.excludedLetters,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            for (int i = 0; i < keysList.length; i++)
              Row(
                children: keysList[i]
                    .map((e) => VirtualKey(
                          letter: e,
                          excluded: excludedLetters.contains(e),
                          onPress: (value) {
                            onPressed(value);
                          },
                        ))
                    .toList(),
              )
          ],
        ),
      ),
    );
  }
}
