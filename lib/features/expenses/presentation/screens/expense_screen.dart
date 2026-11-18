import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_expense_tracker/core/providers/expense_provider.dart';

class ExpenseScreen extends ConsumerWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            barrierColor: Colors.black.withValues(alpha: 0.3),
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    const TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                    ),
                    const TextField(
                      decoration: InputDecoration(labelText: 'Category'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add expense logic here
                        Navigator.pop(context);
                      },
                      child: const Text('Add Expense'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.40,
            backgroundColor: Colors.tealAccent.shade400,
            elevation: 0,
            flexibleSpace: const FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final expense = expenses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  child: Dismissible(
                    key: Key(expense.id),
                    onDismissed: (direction) {
                      ref
                          .read(expensesProvider.notifier)
                          .deleteExpense(
                            expense.id,
                          );
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        style: ListTileStyle.list,
                        leading: expense.category == 'Food'
                            ? const Icon(Icons.fastfood)
                            : expense.category == 'Transportation'
                            ? const Icon(Icons.directions_car)
                            : expense.category == 'Entertainment'
                            ? const Icon(Icons.movie)
                            : const Icon(Icons.shopping_cart),
                        title: Text(' ${expense.title}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("\$${expense.amount}"),
                          ],
                        ),
                        subtitle: Text(
                          "${expense.date.toLocal()}".split(' ')[0],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: expenses.length,
            ),
          ),
        ],
      ),
    );
  }
}
