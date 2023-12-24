import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:word_hurdle_puzzle/wordle.dart';

class HurdleProvider extends ChangeNotifier{
 final random = Random.secure();
 List<String> totalWords = [];
 List<String> rowInputs = [];
 List<String> excludedLetters = [];
 List<Wordle> hurdleBoards = [];
 String targetWord = '';
 int count = 0;
 final lettersPerRow = 5;


 init(){
  totalWords = words.all.where((element) => element.length == 5).toList();
  //print(totalWords);
  generateBoard();
  generateRandomWord();
 }
 generateBoard(){
  hurdleBoards = List.generate(30, (index) => Wordle(letter: ''));
 }

 generateRandomWord(){
  targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
  print(targetWord);
 }

 inputLetter(String letter){
  if(count < lettersPerRow){
   count++;
   rowInputs.add(letter);
   print(rowInputs);
  }

 }

}