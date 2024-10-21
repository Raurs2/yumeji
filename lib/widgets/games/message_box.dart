import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controller.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.sessionCompleted});

  final bool sessionCompleted;

  @override
  Widget build(BuildContext context) {
    String title = 'Muito Bem!';
    String buttonText = 'Nova Palavra';
    if (sessionCompleted) {
      title = 'Parabéns!';
      buttonText = 'Fechar';
    }

    return Consumer<Controller>(
      builder: (_, notifier, __) => AlertDialog(
        title: Center(
            child: Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35))),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Table(
            columnWidths: const {
              0 : FlexColumnWidth(3),
              1 : FlexColumnWidth(1),
            },
            children: [
              buildTableRow(title: 'Partida', stat: notifier.wordsAnswered.toString()),
              buildTableRow(title: 'Tentativas', stat: notifier.tries.toString()),
              buildTableRow(title: 'Tentativas Total', stat: notifier.total_tries.toString()),
              buildTableRow(title: 'Pontos', stat: notifier.score.toString()),
              buildTableRow(title: 'Pontuação Total', stat: notifier.total_score.toString()),

            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (sessionCompleted) {
                      Provider.of<Controller>(context, listen: false).reset();
                      Navigator.of(context).pop();
                    } else {
                      Provider.of<Controller>(context, listen: false)
                          .requestWord(request: true);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(buttonText,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  )),
            ),
          )
        ],
      ),
    );
  }

  TableRow buildTableRow({required String title, required String stat}) {
    return TableRow(
        children: [
          TableCell(child: Text(title)),
          TableCell(child: Text(stat, textAlign: TextAlign.right)),
        ]
    );
  }
}
