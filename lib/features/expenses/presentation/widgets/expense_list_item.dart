import 'package:flutter/material.dart';
import 'package:mini_expense_tracker/features/expenses/data/models/expense.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    required this.expense,
    required this.onDelete,
    super.key,
  });

  final Expense expense;
  final VoidCallback onDelete;

  static const double _radius = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Dismissible(
        key: ValueKey(expense.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDelete(),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(_radius),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Material(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
            side: const BorderSide(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Icon(
                  _iconForCategory(expense.category),
                  color: Colors.blueGrey,
                  size: 28,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.title,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        expense.date.toLocal().toString().split(' ')[0],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '\$${expense.amount}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconForCategory(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood;
      case 'Transportation':
        return Icons.directions_car;
      case 'Entertainment':
        return Icons.movie;
      default:
        return Icons.shopping_cart;
    }
  }
}
