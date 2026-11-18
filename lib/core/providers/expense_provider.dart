import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_expense_tracker/features/expenses/data/models/expense.dart';
import 'package:mini_expense_tracker/features/expenses/data/repositories/expense_repository.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository();
});

final expensesProvider = NotifierProvider<ExpenseNotifier, List<Expense>>(
  ExpenseNotifier.new,
);

class ExpenseNotifier extends Notifier<List<Expense>> {
  @override
  List<Expense> build() {
    final repository = ref.watch(expenseRepositoryProvider);
    return repository.getExpenses();
  }

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void deleteExpense(String id) {
    state = state.where((expense) => expense.id != id).toList();
  }
}
