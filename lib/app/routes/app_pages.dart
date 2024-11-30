import 'package:get/get.dart';

import 'package:money_management/app/modules/business/bindings/business_binding.dart';
import 'package:money_management/app/modules/business/views/business_view.dart';
import 'package:money_management/app/modules/charity/bindings/charity_binding.dart';
import 'package:money_management/app/modules/charity/views/charity_view.dart';
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
import 'package:money_management/app/modules/savings/bindings/savings_binding.dart';
import 'package:money_management/app/modules/savings/views/savings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._(); 

  static const INITIAL = Routes.ONBOARD;

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
      name: _Paths.SAVINGS,
      page: () => SavingsView(),
      binding: SavingsBinding(),
    ),
    GetPage(
      name: _Paths.CHARITY,
      page: () => CharityView(),
      binding: CharityBinding(),
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
    ), GetPage(
      name: _Paths.INTRO_2,
      page: () => IntroScreen2(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_3,
      page: () => IntroScreen3(),
      binding: OnboardBinding(),
    ),
  ];
}
