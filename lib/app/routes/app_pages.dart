import 'package:get/get.dart';

import 'package:money_management/app/modules/business/bindings/business_binding.dart';
import 'package:money_management/app/modules/business/views/business_view.dart';
import 'package:money_management/app/modules/home/bindings/home_binding.dart';
import 'package:money_management/app/modules/home/views/home_view.dart';
import 'package:money_management/app/modules/loans/bindings/loans_binding.dart';
import 'package:money_management/app/modules/loans/views/loans_view.dart';
import 'package:money_management/app/modules/personal/bindings/personal_binding.dart';
import 'package:money_management/app/modules/personal/views/personal_view.dart';
import 'package:money_management/app/modules/savings/bindings/savings_binding.dart';
import 'package:money_management/app/modules/savings/views/savings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL,
      page: () => PersonalView(),
      binding: PersonalBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS,
      page: () => BusinessView(),
      binding: BusinessBinding(),
    ),
    GetPage(
      name: _Paths.LOANS,
      page: () => LoansView(),
      binding: LoansBinding(),
    ),
    GetPage(
      name: _Paths.SAVINGS,
      page: () => SavingsView(),
      binding: SavingsBinding(),
    ),
  ];
}
