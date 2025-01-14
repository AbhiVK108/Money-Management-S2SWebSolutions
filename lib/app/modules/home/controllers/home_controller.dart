import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable list for recently added items
  var recentlyAdded = <Map<String, dynamic>>[].obs;

  // Method to add a new item
  void addNewItem(Map<String, dynamic> item) {
    recentlyAdded.insert(0, item); // Add the new item at the top
  }

  // Summary data
  var totalIncome = 0.0.obs;
  var totalExpenses = 0.0.obs;
  var totalSavings = 0.0.obs;
  var availableBalance = 1000.0.obs;

  // Tabs
  var selectedTab = 0.obs; // 0 = Personal, 1 = Business

  void resetIndex() {
    selectedTab.value = 0;
  }

  @override
  void onInit() {
    super.onInit();
    resetIndex();
    _loadData();
  }

  void _loadData() {
    // Mock data loading
    totalIncome.value = 1500.0;
    totalExpenses.value = 500.0;
    totalSavings.value = totalIncome.value - totalExpenses.value;
  }

  // pie chart

  var incomeData = {
    'Personal': 3000,
    'Business': 5000,
    'Savings': 2000,
    'Loans': 1000,
  }.obs;

  var expenseData = {
    'Personal': 1500,
    'Business': 2500,
    'Savings': 500,
    'Loans': 300,
  }.obs;
}
