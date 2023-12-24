import 'package:flutter/material.dart';

class VirtualKey extends StatelessWidget {
  final String letter;
  final bool excluded;
  final Function(String) onPress;

  const VirtualKey({
    super.key,
    required this.letter,
    required this.excluded,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style:  ElevatedButton.styleFrom(
          backgroundColor: excluded? Colors.red: Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero
        ),

          onPressed: (){
           onPress(letter);
          },
          child: Text(letter)),
    );
  }
}
