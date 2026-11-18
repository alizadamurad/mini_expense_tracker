import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_expense_tracker/core/providers/expense_provider.dart';

class ExpenseScreen extends ConsumerWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    return Scaffold(
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
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
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
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              ref
                                  .read(expensesProvider.notifier)
                                  .deleteExpense(expense.id);
                            },
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "${expense.date.toLocal()}".split(' ')[0],
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
