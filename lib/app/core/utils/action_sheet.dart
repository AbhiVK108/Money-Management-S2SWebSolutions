import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddItemDashboard {
  static void showFullScreenBottomSheet({
    required BuildContext context,
    required Function(Map<String, dynamic>) onAddItem,
  }) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController  descriptionController = TextEditingController();

    String selectedMainCategory = "Personal";
    String selectedSubCategory = "Income";
    String selectedSource = "";

    final Map<String, List<String>> categorySources = {
      "Income": ["Loan", "Gift", "Salary", "Others"],
      "Expenses": ["Food", "Movie", "Travel", "Shopping"],
      "Savings": ["Fixed Deposit", "Mutual Funds", "Piggy Bank", "Others"],
      "Charity": ["Donation", "Event", "Gift", "Others"],
    };

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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Container(
                      height: constraints.maxHeight * 0.9,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Scaffold(
                        appBar: AppBar(
                          automaticallyImplyLeading: true,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          centerTitle: false,
                          title: Text(
                            "Add Item",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 18 * widthFactor,
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
                          padding: EdgeInsets.all(16.0 * widthFactor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // // Main Category Selection
                              // DropdownButtonFormField<String>(
                              //   value: selectedMainCategory,
                              //   items: [
                              //     "Personal",
                              //     "Business",
                              //     "Charity",
                              //     "Savings"
                              //   ]
                              //       .map((category) => DropdownMenuItem<String>(
                              //             value: category,
                              //             child: Text(
                              //               category,
                              //               style: TextStyle(
                              //                 fontFamily: 'Poppins',
                              //                 color: Colors.black,
                              //                 fontSize: 15 * widthFactor,
                              //                 fontWeight: FontWeight.w300,
                              //               ),
                              //             ),
                              //           ))
                              //       .toList(),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       selectedMainCategory = value!;
                              //       selectedSubCategory = "Income";
                              //       selectedSource = "";
                              //     });
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText: "Main Category",
                              //     labelStyle: TextStyle(
                              //       fontFamily: 'Poppins',
                              //       color: Colors.black,
                              //       fontSize: 18 * widthFactor,
                              //       fontWeight: FontWeight.w500,
                              //     ),
                              //     border: OutlineInputBorder(),
                              //   ),
                              // ),
                              // SizedBox(height: 16 * heightFactor),

                              // // Subcategory Selection
                              // DropdownButtonFormField<String>(
                              //   value: selectedSubCategory,
                              //   items: [
                              //     "Income",
                              //     "Expenses",
                              //     "Savings",
                              //     "Charity"
                              //   ]
                              //       .map((subcategory) =>
                              //           DropdownMenuItem<String>(
                              //             value: subcategory,
                              //             child: Text(
                              //               subcategory,
                              //               style: TextStyle(
                              //                 fontFamily: 'Poppins',
                              //                 color: Colors.black,
                              //                 fontSize: 15 * widthFactor,
                              //                 fontWeight: FontWeight.w300,
                              //               ),
                              //             ),
                              //           ))
                              //       .toList(),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       selectedSubCategory = value!;
                              //       selectedSource = "";
                              //     });
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText: "Subcategory",
                              //     labelStyle: TextStyle(
                              //       fontFamily: 'Poppins',
                              //       color: Colors.black,
                              //       fontSize: 17 * widthFactor,
                              //       fontWeight: FontWeight.w500,
                              //     ),
                              //     border: OutlineInputBorder(),
                              //   ),
                              // ),
                              // SizedBox(height: 16 * heightFactor),

                              // Source Selection
                              DropdownButtonFormField<String>(
                                value: selectedSource.isNotEmpty
                                    ? selectedSource
                                    : null,
                                items: categorySources[selectedSubCategory]!
                                    .map((source) => DropdownMenuItem<String>(
                                          value: source,
                                          child: Text(
                                            source,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 15 * widthFactor,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedSource = value!;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Source",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 15 * widthFactor,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 16 * heightFactor),

                              // Date Picker
                              _buildTextField(
                                controller: dateController,
                                label: "Date & Time",
                                hint: "Select a date and time",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today,
                                      color: Colors.teal),
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        final DateTime fullDateTime = DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );
                                        dateController.text =
                                            DateFormat('dd-MM-yyyy HH:mm')
                                                .format(fullDateTime);
                                      }
                                    }
                                  },
                                ),
                                widthFactor: widthFactor,
                              ),
                              SizedBox(height: 16 * heightFactor),

                              // Amount Field
                              _buildTextField(
                                controller: amountController,
                                label: "Amount",
                                keyboardType: TextInputType.number,
                                widthFactor: widthFactor,
                              ),
                              SizedBox(height: 16 * heightFactor),

                              // Description Field
                              _buildTextField(
                                controller: descriptionController,
                                label: "Description",
                                maxLines: 3,
                                widthFactor: widthFactor,
                              ),
                              SizedBox(height: 28 * heightFactor),

                              // Save Button
                              ElevatedButton(
                                onPressed: () {
                                  if (dateController.text.isNotEmpty &&
                                      amountController.text.isNotEmpty &&
                                      selectedSource.isNotEmpty) {
                                    onAddItem({
                                      // 'mainCategory': selectedMainCategory,
                                      // 'subCategory': selectedSubCategory,
                                      'source': selectedSource,
                                      'date': dateController.text,
                                      'amount':
                                          double.parse(amountController.text),
                                      'description': descriptionController.text,
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Please fill in all fields."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14.0 * heightFactor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.teal,
                                ),
                                child: Text("Save",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Colors.white)),
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
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 15 * widthFactor,
          fontWeight: FontWeight.w300,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 15 * widthFactor,
          fontWeight: FontWeight.w200,
        ),
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      style: TextStyle(fontFamily: 'Poppins', fontSize: 14 * widthFactor),
    );
  }
}
