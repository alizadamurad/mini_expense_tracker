import 'package:flutter/material.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  static const _categories = [
    'Food & Drink',
    'Transportation',
    'Shopping',
    'Entertainment',
    'Other',
  ];

  String _category = 'Food & Drink';
  DateTime _date = DateTime.now();

  Future<void> _chooseCategory() async {
    final category = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _categories
              .map(
                (item) => ListTile(
                  title: Text(item),
                  onTap: () => Navigator.pop(context, item),
                ),
              )
              .toList(),
        ),
      ),
    );

    if (category != null) {
      setState(() => _category = category);
    }
  }

  Future<void> _chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => _date = date);
    }
  }

  String get _formattedDate {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${_date.day} ${months[_date.month - 1]} ${_date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.tealAccent.shade400,

                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: const Text(
                      "USD",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),

              _PickerRow(
                icon: Icons.restaurant,
                label: _category,
                onTap: _chooseCategory,
              ),
              const Divider(),
              const TextField(
                decoration: InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.number,
              ),
              const TextField(
                decoration: InputDecoration(labelText: 'Category'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add expense logic here.
                  Navigator.pop(context);
                },
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerRow extends StatelessWidget {
  const _PickerRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(icon, size: 20),
      ),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
