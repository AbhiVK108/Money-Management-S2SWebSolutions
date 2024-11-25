import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PersonalView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: Text(
          'Personal Finance',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildSummaryCards(),
              const SizedBox(height: 20),
              // Income and Expense Breakdown
              Text(
                'Category Breakdown',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              _buildCategoryBreakdown(),
              const SizedBox(height: 20),
              // Add Income/Expense Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: "Add Income/Expense",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.teal,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: Text(
                    'Add Income/Expense',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1, // Adjust the aspect ratio for card sizes
      ),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildSummaryCard('Income', '\$10,000', Colors.teal);
        } else if (index == 1) {
          return _buildSummaryCard('Expenses', '\$5,000', Colors.redAccent);
        } else {
          return _buildSummaryCard('Savings', '\$3,000', Colors.green);
        }
      },
    );
  }

  Widget _buildSummaryCard(String title, String amount, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: color.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              amount,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    return Column(
      children: [
        _buildCategoryTile('Groceries', 300, Colors.orange),
        _buildCategoryTile('Rent', 800, Colors.red),
        _buildCategoryTile('Entertainment', 150, Colors.blue),
        _buildCategoryTile('Utilities', 200, Colors.green),
      ],
    );
  }

  Widget _buildCategoryTile(String category, int amount, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(
          Icons.category,
          color: color,
        ),
      ),
      title: Text(
        category,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        '\$$amount',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

              
// card design category

  Widget _buildPersonalFinanceSection() {
    final List<Map<String, dynamic>> categories = [
      {'title': 'Loans', 'icon': Icons.money_rounded, 'color': Colors.teal},
      {'title': 'Savings', 'icon': Icons.savings_rounded, 'color': Colors.teal},
      {
        'title': 'Insurance',
        'icon': Icons.policy_rounded,
        'color': Colors.teal
      },
      {
        'title': 'Investments',
        'icon': Icons.pie_chart_rounded,
        'color': Colors.teal
      },
      {
        'title': 'Budgeting',
        'icon': Icons.account_balance_wallet_rounded,
        'color': Colors.teal
      },
      {
        'title': 'Expenses',
        'icon': Icons.receipt_long_rounded,
        'color': Colors.teal
      },
    ];
    Widget _buildCategoryTile({
      required String title,
      required IconData icon,
      required Color color,
    }) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: Colors.grey.withOpacity(0.4),
          child: InkWell(
            onTap: () {
              // Add your navigation or action here
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  radius: 30,
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Financial Summary Section
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('Total Income',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('\$10,000',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Total Expenses',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('\$7,500',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Balance',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('\$2,500',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Section Title
          // Text(
          //   'Personal Finance Categories',
          //   style: TextStyle(
          //     fontSize: 22,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.teal,
          //   ),
          // ),
          // const SizedBox(height: 6),
          // Divider(color: Colors.teal.withOpacity(0.5), thickness: 1),
          // const SizedBox(height: 6),
          // Categories Grid
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildCategoryTile(
                  title: category['title'],
                  icon: category['icon'],
                  color: category['color'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
