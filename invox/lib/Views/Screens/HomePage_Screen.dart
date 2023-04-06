import 'package:flutter/material.dart';
import 'package:invox/Repositories/UserRepository.dart';
import 'package:invox/Views/Screens/MyWallets_Screen.dart';
import 'package:invox/Views/Screens/Profile_Screen.dart';
import 'package:invox/Views/Screens/Statistics_Screen.dart';
import 'package:invox/Views/Screens/Transaction_Screen.dart';

import '../Widgets/Add_Transaction_PopUp.dart';
import '../Widgets/HomePage_Graph.dart';
import '../Widgets/TransactionCard.dart';
import '../Widgets/MenuDrawer.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<double> _txns = [
  -100.00,
  -500.00,
  2000.75,
  -150.50,
  -290.00,
];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    UserRepository();
    super.initState();
  }

  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset(
          "assets/images/logo.png",
          height: 50,
          width: 80,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 30,
          ),
          onPressed: () => _key.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.circle_notifications,
              size: 35,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              HomePageGraph(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.tune),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return TransactionCard(
                    amount: _txns[index],
                  );
                },
                itemCount: 5,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: const Color(0xffF0F5FF),
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: BottomNavigationBar(
          onTap: (int x) {
            switch (x) {
              case 0:
                Navigator.pushNamed(context, Transaction.routeName);
                break;
              case 1:
                Navigator.pushNamed(context, MyWalletsScreen.routeName);
                break;
              case 2:
                Navigator.pushNamed(context, Statistics.routeName);
                break;
              case 3:
                Navigator.pushNamed(context, Profile.routeName);
                break;
            }
          },
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: "Transactions",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: "Wallet",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart),
              label: "Statistics",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),
      drawer: const MenuDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Image.asset(
          "assets/images/logo_icon.png",
          width: 35,
        ),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            useSafeArea: true,
            context: context,
            builder: (_) => Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 530,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "New Transaction",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AddTransactionPopUp(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
