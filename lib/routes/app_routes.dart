import 'package:get/get.dart';
import 'package:magic_hardware/features/authentication/screens/login/login.dart';
import 'package:magic_hardware/features/authentication/screens/onboarding/onboarding.dart';
import 'package:magic_hardware/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:magic_hardware/features/authentication/screens/signup/signup.dart';
import 'package:magic_hardware/features/authentication/screens/signup/verify_email.dart';
import 'package:magic_hardware/features/personalization/screens/address/address.dart';
import 'package:magic_hardware/features/personalization/screens/profile/profile.dart';
import 'package:magic_hardware/features/personalization/screens/settings/settings.dart';
import 'package:magic_hardware/features/shop/screens/cart/cart.dart';
import 'package:magic_hardware/features/shop/screens/checkout/checkout.dart';
import 'package:magic_hardware/features/shop/screens/home/home.dart';
import 'package:magic_hardware/features/shop/screens/order/order.dart';
import 'package:magic_hardware/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:magic_hardware/features/shop/screens/store/store.dart';
import 'package:magic_hardware/features/shop/screens/wishlist/wishlist.dart';
import 'package:magic_hardware/routes/routes.dart';

import '../features/shop/models/product_model.dart';
import '../features/shop/screens/product_details/product_detail.dart';

/// A class containing the application's routes.
class AppRoutes {
  /// A list of [GetPage]s that define the routes and their corresponding screens.
  static final pages = [
    GetPage(name: MagicRoutes.home, page: () => const HomeScreen()),
    GetPage(name: MagicRoutes.store, page: () => const StoreScreen()),
    GetPage(name: MagicRoutes.wishlist, page: () => const WishlistScreen()),
    GetPage(name: MagicRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: MagicRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: MagicRoutes.productDetails, page: () => ProductDetailScreen(product: ProductModel.empty())),
    GetPage(name: MagicRoutes.order, page: () => const OrderScreen()),
    GetPage(name: MagicRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: MagicRoutes.cart, page: () => const CartScreen()),
    GetPage(name: MagicRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: MagicRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: MagicRoutes.signUp, page: () => const SignupScreen()),
    GetPage(name: MagicRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: MagicRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: MagicRoutes.resetPassword, page: () => const ForgotPassword()),
    GetPage(name: MagicRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}
