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
 int index = 0;
 bool wins = false;

 final lettersPerRow = 5;
 final totalAttempts = 6;
 int attempts = 0;

  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;

  bool get noAttemptsLeft => attempts == totalAttempts;


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

  bool get isAValidWord => totalWords.contains(rowInputs.join('').toLowerCase());

 inputLetter(String letter){
  if(count < lettersPerRow){
   count++;
   rowInputs.add(letter);
   hurdleBoards[index] = Wordle(letter: letter);
   index++;
   print(rowInputs);
   notifyListeners();
  }

 }

  void deleteLetter() {
   if(rowInputs.isNotEmpty){
    rowInputs.removeAt(rowInputs.length - 1);
    print(rowInputs);
   }
   if(count > 0){
    hurdleBoards[index - 1] = Wordle(letter: '');
    count--;
    index--;
   }
   notifyListeners();
  }

  void checkAnswer() {
    final input = rowInputs.join('');
    if(targetWord == input){
      wins = true;
    }
    else{
     _markLetterOnBoard();
     if(attempts < totalAttempts){
      _goToNextRow();
     }
    }

  }

  void _markLetterOnBoard() {
   for(int i=0; i<hurdleBoards.length; i++){
    if(hurdleBoards[i].letter.isNotEmpty && targetWord.contains(hurdleBoards[i].letter)){
     hurdleBoards[i].existsInTarget = true;
    }
    else if(hurdleBoards[i].letter.isNotEmpty && !targetWord.contains(hurdleBoards[i].letter)){
     hurdleBoards[i].doesNotExistInTarget = true;
     excludedLetters.add(hurdleBoards[i].letter);
    }
   }
   notifyListeners();
  }

  void _goToNextRow() {
   attempts++;
   count = 0;
   rowInputs.clear();
  }

  reset(){
   count = 0;
   index = 0;
   rowInputs.clear();
   hurdleBoards.clear();
   excludedLetters.clear();
   attempts = 0;
   wins = false;
   targetWord = '';
   generateBoard();
   generateRandomWord();
   notifyListeners();
  }

}