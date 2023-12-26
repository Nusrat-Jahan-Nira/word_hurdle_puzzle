
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_puzzle/helper_functions.dart';
import 'package:word_hurdle_puzzle/hurdle_provider.dart';
import 'package:word_hurdle_puzzle/keyboard_view.dart';
import 'package:word_hurdle_puzzle/wordle_view.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});


  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {



  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Hurdle'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.70,
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) =>
                      GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4),
                          itemCount: provider.hurdleBoards.length,
                          itemBuilder: (context, index) {
                            final wordle = provider.hurdleBoards[index];
                            return WordleView(wordle: wordle);
                          }),
                ),
              ),
            ),
            Consumer<HurdleProvider>(
                builder: (context, provider, child) =>
                    KeyboardView(
                      excludedLetters: provider.excludedLetters,
                      onPressed: (value) {
                        provider.inputLetter(value);
                        print(value);
                      },
                    )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<HurdleProvider>(
                builder: (context, provider, child) =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            backgroundColor:  Colors.red,
                          ),
                          onPressed: () {
                            provider.deleteLetter();
                          },
                          child: const Text('DELETE'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                           backgroundColor: provider.count == 5? Colors.green: Colors.grey,
                          ),
                          onPressed: () async {

                            if(provider.count == 5){
                              _handleInput(provider);
                            }
                            else{
                              showMsg(context, 'Word must be 5 letter');
                            }

                          },
                          child: const Text('SUBMIT'),
                        )
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleInput(HurdleProvider provider){
    if (!provider.isAValidWord) {
      showMsg(
          context, 'Not a word from my dictionary!');
      return;
    }
    if (provider.shouldCheckForAnswer) {
      provider.checkAnswer();
    }
    if (provider.wins) {
      showResult(context: context,
        title: 'You Win!!!',
        body: 'The word was ${provider.targetWord}',
        onPlayAgain: (){
          Navigator.pop(context);
          provider.reset();
        },
        onCancel: (){
          Navigator.pop(context);
        },);
    }
    else if(provider.noAttemptsLeft){
      showResult(context: context,
        title: 'You Lost!!!',
        body: 'The word was ${provider.targetWord}',
        onPlayAgain: (){
          Navigator.pop(context);
          provider.reset();
        },
        onCancel: (){
          Navigator.pop(context);
        },);
    }
  }
}
