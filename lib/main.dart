import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'providers/products.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false, //REMOVED DEBUG BANNER FOR AEST. PURPOSES
        title: 'MyShop',
        theme: ThemeData(
          canvasColor: Colors.orange.shade50,
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepOrange,
          ).copyWith(
            secondary: Colors.lightGreen,
            surface: Colors.grey,
            error: Colors.red,
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Anton',
                ),
                bodySmall: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                bodyMedium: TextStyle(
                    color: Color.fromRGBO(250, 249, 246, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Anton'),
                titleLarge: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Anton',
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
                displayMedium: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Anton',
                  fontSize: 16,
                ),
                displayLarge: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepPurple),
              ),
          appBarTheme: AppBarTheme(
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Colors.deepOrange,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.amber,
            ),
            //DID NOT UNDERSTAND
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            centerTitle: true,
          ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
