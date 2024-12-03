import 'package:get/get.dart';

import 'package:money_management/app/modules/auth/bindings/auth_binding.dart';
import 'package:money_management/app/modules/auth/views/login.dart';
import 'package:money_management/app/modules/business/bindings/business_binding.dart';
import 'package:money_management/app/modules/business/views/business_view.dart';
import 'package:money_management/app/modules/fixed_deposit/bindings/fixed_deposit_binding.dart';
import 'package:money_management/app/modules/fixed_deposit/views/fixed_deposit_view.dart';
import 'package:money_management/app/modules/home/bindings/home_binding.dart';
import 'package:money_management/app/modules/home/views/add_entry_view.dart';
import 'package:money_management/app/modules/home/views/home_view.dart';
import 'package:money_management/app/modules/loans/bindings/loans_binding.dart';
import 'package:money_management/app/modules/loans/views/loans_view.dart';
import 'package:money_management/app/modules/onboard/bindings/onboard_binding.dart';
import 'package:money_management/app/modules/onboard/views/intro_screen1.dart';
import 'package:money_management/app/modules/onboard/views/intro_screen2.dart';
import 'package:money_management/app/modules/onboard/views/intro_screen3.dart';
import 'package:money_management/app/modules/onboard/views/onboard_view.dart';
import 'package:money_management/app/modules/personal/bindings/personal_binding.dart';
import 'package:money_management/app/modules/personal/views/personal_view.dart';
import 'package:money_management/app/modules/pie_charts/bindings/pie_charts_binding.dart';
import 'package:money_management/app/modules/pie_charts/views/pie_charts_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ENTRY,
      page: () => AddEntryView(),
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
      name: _Paths.ONBOARD,
      page: () => OnboardView(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_1,
      page: () => IntroScreen1(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_2,
      page: () => IntroScreen2(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_3,
      page: () => IntroScreen3(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.PIE_CHARTS,
      page: () => PieChartsView(),
      binding: PieChartsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.FIXED_DEPOSIT,
      page: () => FixedDepositView(),
      binding: FixedDepositBinding(),
    ),
  ];
}
