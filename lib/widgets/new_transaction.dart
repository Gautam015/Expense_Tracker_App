// ignore_for_file: unnecessary_null_comparison, sdk_version_since

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, required this.onAddTransaction}) : super(key: key);

  final void Function(Transaction transaction) onAddTransaction;
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate!;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount! == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //show error
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content: Text(
              'Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddTransaction(
      Transaction(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardspace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 20,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected'
                                  : formatter.format(_selectedDate),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 20,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected'
                                  : formatter.format(_selectedDate),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}

// class NewTransaction extends StatelessWidget {
//   final Function addTx;
//   final titleController = TextEditingController();
//   final amountController = TextEditingController();

//   NewTransaction(this.addTx);
//   void submitData() {
//     addTx(
//       titleController.text,
//       double.parse(amountController.text),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Container(
//         padding: EdgeInsets.all(5),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Title',
//             ),
//             controller: titleController,
//             // onChanged: (val) {
//             //   titleInput = val;
//             // },
//           ),
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Amount',
//             ),
//             controller: amountController,
//             keyboardType: TextInputType.number,
//             onSubmitted: (_) => submitData,
//             // onChanged: (val) => amountInput = val,
//           ),
//           TextButton( 
//             child: Text(
//               'Add Transaction',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.purple,
//               ),
//             ),
//             onPressed: () {},
//           )
//         ]),
//       ),
//     );
//   }
// }
