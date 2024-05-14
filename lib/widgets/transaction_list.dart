import 'package:flutter/material.dart';
import '../models/transaction.dart';
// import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final void Function(Transaction transaction) onRemoveTrasnaction;

  TransactionList(this.transactions, this.onRemoveTrasnaction);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal,),
            ),
            key: ValueKey(transactions[index]),
            onDismissed: (direction){
              onRemoveTrasnaction(transactions[index]);
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transactions[index].title, 
                    //apply the theme of titleLarge to this widget
                    style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text('\$${transactions[index].amount.toString()}'),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(categoryIcons[transactions[index].category]),
                            const SizedBox(width: 8),
                            Text(transactions[index].formattedDate),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });

    // return Container(
    //   height: 300,
    //   child: ListView.builder(
    //     itemBuilder: (ctx, index) {
    //       return Card(
    //         child: Row(
    //           children: [
    //             Container(
    //               margin: EdgeInsets.symmetric(
    //                 vertical: 10,
    //                 horizontal: 15,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                     color: Colors.purple,
    //                     style: BorderStyle.solid,
    //                     width: 2),
    //               ),
    //               padding: EdgeInsets.all(10),
    //               child: Text(
    //                 '\$' + transactions[index].amount.toString(),
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 20,
    //                   color: Colors.purple,
    //                 ),
    //               ),
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(transactions[index].title,
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.bold,
    //                     )),
    //                 Text(
    //                   DateFormat.yMMMd().format(transactions[index].date),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //     itemCount: transactions.length,
    //   ),
    // );
  }
}
