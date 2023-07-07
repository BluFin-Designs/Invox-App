import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invox/Models/CategoryModel.dart';
import 'package:invox/Models/Transaction_Model.dart';
import 'package:invox/Models/WalletModel.dart';
import 'package:invox/Repositories/CategoryRepository.dart';
import 'package:invox/blocs/categories_bloc.dart';
import 'package:invox/blocs/cubits/auth_cubit.dart';

import '../Views/Screens/Budget_Screen.dart';
import '../Views/Screens/Categories_Screen.dart';
import '../Views/Screens/GoalDetails_Screen.dart';
import '../Views/Screens/HomePage_Screen.dart';
import '../Views/Screens/LoginSignUp_Screen.dart';
import '../Views/Screens/MyWallets_Screen.dart';
import '../Views/Screens/Preferences_Screen.dart';
import '../Views/Screens/Profile_Screen.dart';
import '../Views/Screens/SavingGoals_Screen.dart';
import '../Views/Screens/Statistics_Screen.dart';
import '../Views/Screens/Transaction_Screen.dart';
import 'Repositories/WalletRepository.dart';
import 'blocs/transactions_bloc.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialise Firebase
  await Hive.initFlutter(); // initialise Hive DataBase

  //Register Adapter
  Hive.registerAdapter(WalletAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionCategoryModelAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());

  //Open HiveBox
  await Hive.openBox("database");

  // var mainBox = Hive.box("database");
  // mainBox.clear();

  // adding default wallets.
  WalletRepository();
  CategoryRepository();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xFF7286D3),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xff8EA7E9),
          ),
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitial;
          },
          builder: (context, state) {
            if (state is LoggedInState) {
              return BlocProvider(
                create: (context) => TransactionsBloc(),
                child: const HomePage(),
              );
            }
            return const LoginSignUp();
          },
        ),
        routes: {
          LoginSignUp.routeName: (ctx) => const LoginSignUp(),
          HomePage.routeName: (ctx) => const HomePage(),
          Profile.routeName: (ctx) => const Profile(),
          Transaction.routeName: (ctx) => const Transaction(),
          Statistics.routeName: (ctx) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => CategoriesBloc()),
                  BlocProvider(create: (context) => TransactionsBloc()),
                ],
                child: const Statistics(),
              ),
          MyWalletsScreen.routeName: (ctx) => MyWalletsScreen(),
          Preferences.routeName: (ctx) => const Preferences(),
          CategoriesPage.routeName: (ctx) => BlocProvider(
                create: (context) => CategoriesBloc(),
                child: const CategoriesPage(),
              ),
          BudgetPage.routeName: (ctx) => const BudgetPage(),
          SavingGoals.routeName: (ctx) => const SavingGoals(),
          GoalDetailsPage.routeName: (ctx) => const GoalDetailsPage(),
        },
      ),
    );
  }
}
