import 'package:app_kanji/controllers/flashcards_notifier.dart';
import 'package:app_kanji/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../mainwrapper.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => AlertDialog(
        title: Text(
            notifier.isSessionCompleted
                ? 'Parabéns! Cartas diárias estudadas.'
                : 'Rever cartas incorretas?',
            textAlign: TextAlign.center),
        actions: [
          Table(
            columnWidths: const {
              0 : FlexColumnWidth(3),
              1 : FlexColumnWidth(1),
            },
            children: [
              buildTableRow(title: 'Partida', stat: notifier.round.toString()),
              buildTableRow(title: 'Cartas', stat: notifier.card.toString()),
              buildTableRow(title: 'Acertadas', stat: notifier.correct.toString()),
              buildTableRow(title: 'Erradas', stat: notifier.incorrect.toString()),
              buildTableRow(title: 'Porcentagem de acerto', stat: '${notifier.correctPercentage.toString()}%'),

            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  notifier.isSessionCompleted
                      ? const SizedBox()
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => const Home(),
                                ),
                                ModalRoute.withName('/'));
                          },
                          child: const Text('Rever cartas incorretas')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const MainWrapper(),
                            ),
                            ModalRoute.withName('/'));
                      },
                      child: const Text('Finalizar'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TableRow buildTableRow({required String title, required String stat}) {
    return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TableCell(child: Text(title)),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TableCell(child: Text(stat, textAlign: TextAlign.right)),
                ),
              ]
            );
  }
}
