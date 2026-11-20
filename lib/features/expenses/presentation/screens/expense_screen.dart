import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_expense_tracker/core/providers/expense_provider.dart';
import 'package:mini_expense_tracker/features/expenses/presentation/widgets/add_expense_sheet.dart';
import 'package:mini_expense_tracker/features/expenses/presentation/widgets/expense_list_item.dart';

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
        onPressed: () => showModalBottomSheet<void>(
          builder: (_) => const AddExpenseSheet(),
          isScrollControlled: true,
          barrierColor: Colors.black.withValues(alpha: 0.3),
          context: context,
        ),
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
                return ExpenseListItem(
                  expense: expense,
                  onDelete: () {
                    ref
                        .read(expensesProvider.notifier)
                        .deleteExpense(expense.id);
                  },
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
