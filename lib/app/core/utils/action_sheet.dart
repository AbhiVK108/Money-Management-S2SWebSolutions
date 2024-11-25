import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/app/core/themes/app_colors.dart';

class AddItem {
  static void showFullScreenBottomSheet({
    required BuildContext context,
    required Function(Map<String, dynamic>) onAddItem,
  }) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController sourceController = TextEditingController();
    final TextEditingController noteController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    String selectedCategory = "Income";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return LayoutBuilder(
              builder: (context, constraints) {
                double heightFactor =
                    constraints.maxHeight / 812; // Base height
                double widthFactor = constraints.maxWidth / 375; // Base width

                return SafeArea(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    child: Container(
                      height: constraints.maxHeight * 0.9, // Fixed height
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Scaffold(
                        appBar: AppBar(
                          automaticallyImplyLeading: true,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          centerTitle: false,
                          title: Text(
                            selectedCategory,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  18 * widthFactor, // Responsive font size
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        body: Padding(
                          padding: EdgeInsets.all(8.0 * widthFactor),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.0 * widthFactor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // ChoiceChip Section
                                      // Wrap Section with Customized Chips
                                      Wrap(
                                        spacing: 8.0 * widthFactor,
                                        runSpacing: 8.0 * heightFactor,
                                        children: [
                                          "Income",
                                          "Expenses",
                                          "Loans",
                                          "Savings"
                                        ].map((category) {
                                          final bool isSelected =
                                              selectedCategory == category;

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedCategory = category;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 8.0 * heightFactor,
                                                horizontal: 12.0 * widthFactor,
                                              ),
                                              decoration: BoxDecoration(
                                                gradient: isSelected
                                                    ? LinearGradient(
                                                        colors: [
                                                          AppColors.tealColor,
                                                          AppColors.tealColor
                                                              .withOpacity(0.8),
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      )
                                                    : null,
                                                color: isSelected
                                                    ? null
                                                    : AppColors.backgroundColor,
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Colors.transparent
                                                      : AppColors.tealColor
                                                          .withOpacity(0.5),
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: isSelected
                                                    ? [
                                                        BoxShadow(
                                                          color: AppColors
                                                              .tealColor
                                                              .withOpacity(0.4),
                                                          blurRadius: 8,
                                                          offset: const Offset(
                                                              0, 3),
                                                        ),
                                                      ]
                                                    : null,
                                              ),
                                              child: Text(
                                                category,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 12 * widthFactor,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),

                                      SizedBox(height: 18 * heightFactor),

                                      // Date Picker
                                      _buildTextField(
                                        controller: dateController,
                                        label: "Date & Time",
                                        hint: "Select a date and time",
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.calendar_today,
                                              color: Colors.teal, size: 24),
                                          onPressed: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    primaryColor: Colors.teal,
                                                    hintColor: Colors.teal,
                                                    colorScheme:
                                                        ColorScheme.light(
                                                      primary: Colors.teal,
                                                      onPrimary: Colors.white,
                                                      onSurface: Colors.black,
                                                    ),
                                                    dialogBackgroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );
                                            if (pickedDate != null) {
                                              TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return Theme(
                                                    data: ThemeData.light()
                                                        .copyWith(
                                                      primaryColor: Colors.teal,
                                                      hintColor: Colors.teal,
                                                      timePickerTheme:
                                                          TimePickerThemeData(
                                                        dialHandColor:
                                                            Colors.teal,
                                                        dialBackgroundColor:
                                                            Colors.white,
                                                        hourMinuteColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                          (states) => states.contains(
                                                                  MaterialState
                                                                      .selected)
                                                              ? Colors.teal
                                                              : Colors.white,
                                                        ),
                                                        hourMinuteTextColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                          (states) => states.contains(
                                                                  MaterialState
                                                                      .selected)
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                              );
                                              if (pickedTime != null) {
                                                final DateTime fullDateTime =
                                                    DateTime(
                                                  pickedDate.year,
                                                  pickedDate.month,
                                                  pickedDate.day,
                                                  pickedTime.hour,
                                                  pickedTime.minute,
                                                );
                                                dateController.text =
                                                    DateFormat(
                                                            'dd-MM-yyyy HH:mm')
                                                        .format(fullDateTime);
                                              }
                                            }
                                          },
                                        ),
                                        widthFactor: widthFactor,
                                      ),
                                      SizedBox(height: 18 * heightFactor),

                                      // Other Input Fields
                                      _buildTextField(
                                        controller: amountController,
                                        label: "Amount",
                                        keyboardType: TextInputType.number,
                                        widthFactor: widthFactor,
                                      ),
                                      // SizedBox(height: 18 * heightFactor),
                                      // _buildTextField(
                                      //   controller: sourceController,
                                      //   label: "Source (e.g., Salary, Loan, etc.)",
                                      //   widthFactor: widthFactor,
                                      // ),
                                      // SizedBox(height: 18 * heightFactor),
                                      // _buildTextField(
                                      //   controller: noteController,
                                      //   label: "Note",
                                      //   widthFactor: widthFactor,
                                      // ),
                                      // SizedBox(height: 18 * heightFactor),
                                      // _buildTextField(
                                      //   controller: descriptionController,
                                      //   label: "Description",
                                      //   maxLines: 3,
                                      //   widthFactor: widthFactor,
                                      // ),

                                      SizedBox(height: 28 * heightFactor),

                                      // Save Button
                                      // Save Button
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.tealColor,
                                              AppColors.tealColor
                                                  .withOpacity(0.8),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.tealColor
                                                  .withOpacity(0.4),
                                              blurRadius: 8,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors
                                                .transparent, // Transparent to show gradient
                                            shadowColor: Colors
                                                .transparent, // Remove default shadow
                                            padding: EdgeInsets.symmetric(
                                              vertical: 13.0 * heightFactor,
                                            ),
                                          ),
                                          onPressed: () {
                                            if (dateController
                                                    .text.isNotEmpty &&
                                                amountController
                                                    .text.isNotEmpty) {
                                              onAddItem({
                                                'category':
                                                    selectedCategory, // Correct value
                                                'date': dateController.text,
                                                'amount': double.parse(
                                                    amountController.text),
                                                'source': sourceController.text,
                                                'note': noteController.text,
                                                'description':
                                                    descriptionController.text,
                                              });
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Please fill in all fields."),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14 * widthFactor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  static Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required double widthFactor,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      style: TextStyle(fontSize: 14 * widthFactor),
    );
  }
}
