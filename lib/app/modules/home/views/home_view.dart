// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management/app/core/themes/app_colors.dart';
import 'package:money_management/app/core/themes/app_textstyles.dart';
import 'package:money_management/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.tealColor,
        toolbarHeight: 10,
      ),
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
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  child: Container(
                    height: 220 * heightFactor,
                    width: double.infinity,
                    color: AppColors.tealColor,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.0 * heightFactor),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                                    Text('Available Balance',
                                        style: AppTextStyles.availableBalance),
                                    Obx(
                                      () => Text(
                                          '\₹${controller.availableBalance.value.toStringAsFixed(2)}',
                                          style: AppTextStyles.balanceAmount),
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
                          fontFamily: 'Poppins',
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
                                  children: [
                                    Lottie.asset(
                                        'assets/No-Data-Animation.json',
                                        height: 120 * heightFactor,
                                        width: 120 * widthFactor),
                                    Text(
                                      'No Data Available',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.PIE_CHARTS);
        },
        backgroundColor: Colors.teal, // Set the background color to teal
        foregroundColor: Colors.white, // Set the icon color to white
        child: Image.asset(
          'assets/stats.png',
          height: 22,
          width: 22,
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
                fontFamily: 'Poppins',
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
                  fontFamily: 'Poppins',
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
        child: Column(
          children: [
            Row(
              children: [
                _buildTabButton('Personal', 0, heightFactor, widthFactor),
                SizedBox(
                  width: 8 * widthFactor,
                ),
                _buildTabButton('Business', 1, heightFactor, widthFactor),
              ],
            ),
            SizedBox(height: 9 * heightFactor), // Spacer between rows
            Row(
              children: [
                _buildTabButton('Loans', 2, heightFactor, widthFactor),
                SizedBox(
                  width: 8 * widthFactor,
                ),
                _buildTabButton('Fixed Deposit', 3, heightFactor, widthFactor),
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
          if (controller.selectedTab.value == 0) {
            Get.toNamed(Routes.PERSONAL);
          } else if (controller.selectedTab.value == 1) {
            Get.toNamed(Routes.BUSINESS);
            controller.resetIndex();
          } else if (controller.selectedTab.value == 2) {
            Get.toNamed(Routes.LOANS);
            controller.resetIndex();
          } else if (controller.selectedTab.value == 3) {
            Get.toNamed(Routes.FIXED_DEPOSIT);
            controller.resetIndex();
          } else {
            Get.toNamed(Routes.HOME);
            controller.resetIndex();
          }
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
                : Colors.grey.shade200,
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
                fontFamily: 'Poppins',
                fontSize: 14 * heightFactor,
                fontWeight: FontWeight.w500,
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

          // Determine the color based on the category
          Color categoryColor;
          switch (item['subCategory']) {
            case 'Income':
              categoryColor = Colors.green;
              break;
            case 'Expenses':
              categoryColor = Colors.red;
              break;
            case 'Savings':
              categoryColor = Colors.blue;
              break;
            case 'Loans':
              categoryColor = Colors.purple;
              break;
            default:
              categoryColor = Colors.grey;
          }

          return GestureDetector(
            onTap: () {
              // Add your navigation or action here
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(
                horizontal: 16 * widthFactor,
                vertical: 8 * heightFactor,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: GlassmorphicContainer(
                width: double.infinity,
                height: 160 * heightFactor,
                borderRadius: 16,
                blur: 20,
                alignment: Alignment.bottomCenter,
                border: 1,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.grey.shade300,
                    Colors.white.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.5), Colors.grey.shade200],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16 * widthFactor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row for Icon, Category, and Amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24 * widthFactor,
                                backgroundColor: categoryColor.withOpacity(0.2),
                                child: Icon(
                                  Icons.category,
                                  size: 20 * heightFactor,
                                  color: categoryColor,
                                ),
                              ),
                              SizedBox(width: 12 * widthFactor),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Subcategory (Income, Expenses, etc.)
                                  Text(
                                    item['subCategory'],
                                    style: TextStyle(
                                      fontSize: 16 * heightFactor,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  // Main category (Business/Personal)
                                  Text(
                                    item['mainCategory'],
                                    style: TextStyle(
                                      fontSize: 14 * heightFactor,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                      SizedBox(height: 8 * heightFactor),
                      // Row for Date and Source
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0 * widthFactor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Date
                            Text(
                              item['date'],
                              style: TextStyle(
                                fontSize: 12 * heightFactor,
                                color: Colors.grey,
                              ),
                            ),
                            // Source
                            Text(
                              "Source: ${item['source']}",
                              style: TextStyle(
                                fontSize: 12 * heightFactor,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8 * heightFactor),
                      // Description
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0 * widthFactor),
                        child: Text(
                          item['description'],
                          style: TextStyle(
                            fontSize: 14 * heightFactor,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // pie chart

  // Function to return a color for each section
  Color _getColorForSection(String key) {
    switch (key) {
      case 'Personal':
        return Colors.blue;
      case 'Business':
        return Colors.green;
      case 'Savings':
        return Colors.orange;
      case 'Loans':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
