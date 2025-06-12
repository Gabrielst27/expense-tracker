import 'package:expense_tracker/enums/category_enum.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ECategory _selectedCategory = ECategory.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final maxWidth = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (maxWidth > 600)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(label: Text('Título')),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            maxLength: 50,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: 'R\$ ',
                              label: Text('Valor'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(label: Text('Título')),
                    ),
                  if (maxWidth > 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: ECategory.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
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
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDate == null
                                      ? 'Nenhuma data selecionada'
                                      : DateFormat.yMd().format(_selectedDate!),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000, 1, 1),
                                    lastDate: DateTime.now(),
                                  );
                                  setState(() {
                                    _selectedDate = pickedDate;
                                  });
                                },
                                icon: const Icon(Icons.calendar_month),
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
                            maxLength: 50,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: 'R\$ ',
                              label: Text('Valor'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDate == null
                                      ? 'Nenhuma data selecionada'
                                      : DateFormat.yMd().format(_selectedDate!),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000, 1, 1),
                                    lastDate: DateTime.now(),
                                  );
                                  setState(() {
                                    _selectedDate = pickedDate;
                                  });
                                },
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (maxWidth <= 600)
                        DropdownButton(
                          value: _selectedCategory,
                          items: ECategory.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
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
                        style: ElevatedButton.styleFrom(),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final amountNumberValue = double.tryParse(
                            _amountController.text,
                          );
                          if (_titleController.text.trim().isEmpty ||
                              amountNumberValue == null ||
                              amountNumberValue <= 0 ||
                              _selectedDate == null) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Conteúdo inválido'),
                                content: const Text(
                                  'Certifique-se de colocar os valores necessários para salvar a despesa',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: Text('Ok'),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }
                          widget.onAddExpense(
                            Expense(
                              title: _titleController.text,
                              amount: amountNumberValue,
                              date: _selectedDate!,
                              category: _selectedCategory,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('Salvar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
