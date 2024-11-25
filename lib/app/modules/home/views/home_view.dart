
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management/app/core/themes/app_colors.dart';
import 'package:money_management/app/core/themes/app_textstyles.dart';
import 'package:money_management/app/core/utils/action_sheet.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  bool _animate = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Ensure it's not white
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double heightFactor = constraints.maxHeight / 812; // Base height
          double widthFactor = constraints.maxWidth / 375; // Base width

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  child: Container(
                    height: 217 * heightFactor,
                    width: double.infinity,
                    color: AppColors.tealColor,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0 * heightFactor),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Available Balance Section
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8.0 * heightFactor,
                                    horizontal: 18.0 * widthFactor,
                                  ),
                                  child: CircleAvatar(
                                    radius: 25.0 * widthFactor,
                                    backgroundImage:
                                        AssetImage('assets/man.png'),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Available Balance',
                                      style: AppTextStyles.whiteSmall.copyWith(
                                        fontSize: 16 * heightFactor,
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        '\₹${controller.availableBalance.value.toStringAsFixed(2)}',
                                        style: AppTextStyles.whiteLargeBold
                                            .copyWith(
                                          fontSize: 20 * heightFactor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 14 * heightFactor),
                            // Income and Expenses Cards
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0 * widthFactor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildFinanceCard(
                                    title: 'Income',
                                    value: controller.totalIncome,
                                    color: Colors.green,
                                    graphImagePath: 'assets/chart-up.png',
                                    widthFactor: widthFactor,
                                    heightFactor: heightFactor,
                                  ),
                                  _buildFinanceCard(
                                    title: 'Expenses',
                                    value: controller.totalExpenses,
                                    color: Colors.red,
                                    graphImagePath: 'assets/chart-down.png',
                                    widthFactor: widthFactor,
                                    heightFactor: heightFactor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20 * heightFactor),
                // Tabs Section
                _buildTabs(context, heightFactor, widthFactor),
                SizedBox(
                  height: 20 * heightFactor,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22 * widthFactor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Recent Records", // Section Title
                        style: TextStyle(
                          fontSize:
                              20 * heightFactor, // You can adjust the font size
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealColor, // Or use your theme color
                        ),
                      ),
                      Image.asset(
                        'assets/history.png',
                        height: 23 * heightFactor,
                        width: 23 * widthFactor,
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 8 * heightFactor,
                ),
                Expanded(
                  child: Obx(() {
                    return SizedBox(
                        height: constraints.maxHeight * 0.7,
                        child: controller.recentlyAdded.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                        'assets/No-Data-Animation.json',
                                        height: 120 * heightFactor,
                                        width: 120 * widthFactor),
                                    Text(
                                      'No Data Available',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                    ),
                                    SizedBox(
                                      height: 30.0 * heightFactor,
                                    )
                                  ],
                                ),
                              )
                            : _buildRecentlyAddedList(
                                heightFactor, widthFactor));
                  }),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Container(
        height: 55, // Adjust height as needed
        width: 55, // Adjust width as needed
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.tealColor,
              AppColors.tealColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30), // Circular for FAB look
          boxShadow: [
            BoxShadow(
              color: AppColors.tealColor.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            AddItem.showFullScreenBottomSheet(
              context: context,
              onAddItem: (newItem) {
                controller.addNewItem(newItem);
              },
            );
          },
          backgroundColor:
              Colors.transparent, // Makes the FAB blend with container
          elevation: 0, // Removes FAB shadow since decoration handles it
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFinanceCard({
    required String title,
    required RxDouble value,
    required Color color,
    required String graphImagePath,
    required double widthFactor,
    required double heightFactor,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              blurStyle: BlurStyle.outer,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(6.0 * widthFactor),
        margin: EdgeInsets.symmetric(horizontal: 5 * widthFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15 * widthFactor,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryTextColor,
              ),
            ),
            SizedBox(height: 2 * heightFactor),
            Image.asset(
              graphImagePath,
              height: 40 * heightFactor,
              color: color,
            ),
            SizedBox(height: 2 * heightFactor),
            Obx(
              () => Text(
                '\₹${value.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 15 * widthFactor,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs(
      BuildContext context, double heightFactor, double widthFactor) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: 14 * widthFactor),
        padding: EdgeInsets.all(4 * heightFactor),
        // decoration: BoxDecoration(
        //   color: AppColors.backgroundColor,
        //   borderRadius: BorderRadius.circular(12),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.2),
        //       blurRadius: 8,
        //       offset: const Offset(0, 4),
        //     ),
        //   ],
        // ),
        child: Column(
          children: [
            Row(
              children: [
                _buildTabButton('All', 0, heightFactor, widthFactor),
                SizedBox(
                  width: 8 * widthFactor,
                ),
                _buildTabButton('Personal', 1, heightFactor, widthFactor),
              ],
            ),
            SizedBox(height: 9 * heightFactor), // Spacer between rows
            Row(
              children: [
                _buildTabButton('Business', 2, heightFactor, widthFactor),
                SizedBox(
                  width: 8 * widthFactor,
                ),
                _buildTabButton('Charity', 3, heightFactor, widthFactor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(
      String label, int index, double heightFactor, double widthFactor) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectedTab.value = index;
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2 * widthFactor),
          padding: EdgeInsets.symmetric(vertical: 12 * heightFactor),
          decoration: BoxDecoration(
            gradient: controller.selectedTab.value == index
                ? LinearGradient(
                    colors: [
                      AppColors.tealColor,
                      AppColors.tealColor.withOpacity(0.8)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: controller.selectedTab.value == index
                ? null
                : AppColors.backgroundColor,
            border: Border.all(
              color: controller.selectedTab.value == index
                  ? Colors.transparent
                  : AppColors.tealColor.withOpacity(0.5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: controller.selectedTab.value == index
                ? [
                    BoxShadow(
                      color: AppColors.tealColor.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14 * heightFactor,
                fontWeight: FontWeight.bold,
                color: controller.selectedTab.value == index
                    ? Colors.white
                    : AppColors.primaryTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Recently added items list
  Widget _buildRecentlyAddedList(double heightFactor, double widthFactor) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.recentlyAdded.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = controller.recentlyAdded[index];

          Color categoryColor;
          if (item['category'] == 'Income') {
            categoryColor = Colors.green;
          } else if (item['category'] == 'Expenses') {
            categoryColor = Colors.red;
          } else if (item['category'] == 'Loans') {
            categoryColor = Colors.orange;
          } else if (item['category'] == 'Savings') {
            categoryColor = Colors.blue;
          } else {
            categoryColor = Colors.grey;
          }

          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16 * widthFactor,
              vertical: 8 * heightFactor,
            ),
            padding: EdgeInsets.all(12 * heightFactor),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon with dynamic color
                CircleAvatar(
                  radius: 22 * widthFactor,
                  backgroundColor: categoryColor.withOpacity(0.2),
                  child: Icon(
                    Icons.category, // Replace with relevant icons if needed
                    size: 20 * heightFactor,
                    color: categoryColor,
                  ),
                ),
                SizedBox(width: 12 * widthFactor),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['category'],
                        style: TextStyle(
                          fontSize: 16 * heightFactor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4 * heightFactor),
                      Text(
                        item['date'],
                        style: TextStyle(
                          fontSize: 12 * heightFactor,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                // Amount
                Text(
                  "\₹${item['amount'].toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16 * heightFactor,
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
