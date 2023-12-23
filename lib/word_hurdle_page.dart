import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_puzzle/hurdle_provider.dart';
import 'package:word_hurdle_puzzle/wordle_view.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {

  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context,listen: false).init();
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
              child: Consumer<HurdleProvider>(
                builder: (context, provider, child) =>
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4
                    ),
                    itemCount: provider.hurdleBoards.length,
                    itemBuilder: (context,index){
                      final wordle = provider.hurdleBoards[index];
                      return WordleView(wordle: wordle);
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
