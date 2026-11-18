import 'package:mini_expense_tracker/features/expenses/data/models/expense.dart';

class ExpenseRepository {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      title: 'Grocery Shopping',
      amount: 45.50,
      category: 'Food',
      date: DateTime(2026, 11, 17),
    ),
    Expense(
      id: '2',
      title: 'Uber',
      amount: 12.00,
      category: 'Transportation',
      date: DateTime(2026, 11, 16),
    ),
    Expense(
      id: '3',
      title: 'Netflix',
      amount: 9.99,
      category: 'Entertainment',
      date: DateTime(2026, 11, 15),
    ),
    Expense(
      id: '4',
      title: 'Coffee',
      amount: 4.50,
      category: 'Food',
      date: DateTime(2026, 11, 14),
    ),
    Expense(
      id: '5',
      title: 'Grocery Shopping',
      amount: 45.50,
      category: 'Food',
      date: DateTime(2026, 11, 17),
    ),
    Expense(
      id: '6',
      title: 'Uber',
      amount: 12.00,
      category: 'Transportation',
      date: DateTime(2026, 11, 16),
    ),
    Expense(
      id: '7',
      title: 'Netflix',
      amount: 9.99,
      category: 'Entertainment',
      date: DateTime(2026, 11, 15),
    ),
    Expense(
      id: '8',
      title: 'Coffee',
      amount: 4.50,
      category: 'Food',
      date: DateTime(2026, 11, 14),
    ),
    Expense(
      id: '9',
      title: 'Grocery Shopping',
      amount: 45.50,
      category: 'Food',
      date: DateTime(2026, 11, 17),
    ),
    Expense(
      id: '10',
      title: 'Uber',
      amount: 12.00,
      category: 'Transportation',
      date: DateTime(2026, 11, 16),
    ),
    Expense(
      id: '11',
      title: 'Netflix',
      amount: 9.99,
      category: 'Entertainment',
      date: DateTime(2026, 11, 15),
    ),
    Expense(
      id: '12',
      title: 'Coffee',
      amount: 4.50,
      category: 'Food',
      date: DateTime(2026, 11, 14),
    ),
  ];

  List<Expense> getExpenses() {
    return _expenses;
  }
}
