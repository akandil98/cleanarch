import 'package:cleanarch/core/utils/app_strings.dart';
import 'package:cleanarch/features/random_quote/presentation/screens/quote_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = '/';

  //static const String favouriteQuoteRoute = '/favouriteQuote';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const QuoteScreen(),
        );
      // case Routes.favouriteQuoteRoute:
      //   return MaterialPageRoute(
      //       builder: (context) => const FavouriteQuoteScreen());
      default:
        return undefindedRoute();
    }
  }

  static Route<dynamic> undefindedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}


// Mavogator.pushNamed(context, Routes.favouriteQuote)