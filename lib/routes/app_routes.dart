

import 'package:adaroapp_admin_panel/features/authentication/screens/forget_password/forget_password.dart';
import 'package:adaroapp_admin_panel/features/authentication/screens/reset_password/reset_password.dart';
import 'package:adaroapp_admin_panel/features/media/media.dart';
import 'package:adaroapp_admin_panel/features/personalization/screens/profile/profile.dart';
import 'package:adaroapp_admin_panel/features/personalization/screens/settings/settings.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/customer/all_customers/customers.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/customer/customer_detail/customer_detail.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/order/all_orders/orders.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/order/orders_detail/order_detail.dart';
import 'package:adaroapp_admin_panel/routes/routes.dart';
import 'package:adaroapp_admin_panel/routes/routes_middleware.dart';

import 'package:get/get.dart';

import '../features/authentication/screens/login/login.dart';

import '../features/shop/screens/banner/all_banner/banners.dart';
import '../features/shop/screens/banner/create_banner/create_banner.dart';
import '../features/shop/screens/banner/edit_banner/edit_banner.dart';
import '../features/shop/screens/dashboard/dashboard_screen.dart';


class TAppRoute {
  static final List<GetPage> pages =[
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: TRoutes.dashboard, page: () => const DashboardScreen(), middlewares: [TRouteMiddleware()]),
    GetPage(name: TRoutes.media, page: () => const MediaScreen(), middlewares: [TRouteMiddleware()]),

    // Banners
    GetPage(name: TRoutes.banners, page: () => const BannersScreen(), middlewares: [TRouteMiddleware()]),
    GetPage(name: TRoutes.createBanner, page: () => const CreateBannerScreen(), middlewares: [TRouteMiddleware()]),
    GetPage(name: TRoutes.editBanner, page: () => const EditBannerScreen(), middlewares: [TRouteMiddleware()]),

    // Customers
    GetPage(name: TRoutes.customers, page: () => const CustomersScreen(), middlewares: [TRouteMiddleware()]),
    GetPage(name: TRoutes.customerDetails, page: () => const CustomerDetailScreen(), middlewares: [TRouteMiddleware()]),

    // Orders
    GetPage(name: TRoutes.orders, page: () => const OrdersScreen(), middlewares: [TRouteMiddleware()]),
    GetPage(name: TRoutes.orderDetails, page: () => const OrderDetailScreen(), middlewares: [TRouteMiddleware()]),

    GetPage(name: TRoutes.profile, page: () => const ProfileScreen(), middlewares: [TRouteMiddleware()]),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen(), middlewares: [TRouteMiddleware()]),


  ];
}