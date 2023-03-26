import 'package:flutter/material.dart';

import './Categories_Screen.dart';
import './Budget_Screen.dart';
import '../Widgets/PreferenceButtonWidget.dart';
import '../Widgets/PreferenceSwitchWidget.dart';
import './GoalDetails_Screen.dart';

class Preferences extends StatelessWidget {
  static const routeName = '/preferences';
  const Preferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _autoReadSms = false;
    bool _backUpData = true;
    bool _notifyBudget = true;
    bool _passCode = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferences"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Theme",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              PreferenceButtonWidget(
                title: "Categories",
                icon: Icons.category,
                onClick: () {
                  Navigator.of(context).pushNamed(CategoriesPage.routeName);
                },
              ),
              PreferenceButtonWidget(
                title: "Budgets",
                icon: Icons.attach_money_rounded,
                onClick: () {
                  Navigator.of(context).pushNamed(BudgetPage.routeName);
                },
              ),
              PreferenceButtonWidget(
                title: "Saving Goals",
                icon: Icons.savings_sharp,
                onClick: () {
                  Navigator.of(context).pushNamed(BudgetDetailsPage.routeName);
                },
              ),
              PreferenceButtonWidget(
                title: "Export Statements",
                icon: Icons.receipt_long,
                onClick: () {},
              ),
              const SizedBox(
                height: 30,
              ),
              PreferenceSwitchWidget(
                switchValue: _autoReadSms,
                title: "Auto Read SMS",
                onChanged: () {},
              ),
              PreferenceSwitchWidget(
                switchValue: _backUpData,
                title: "Backup Data",
                onChanged: () {},
              ),
              PreferenceSwitchWidget(
                switchValue: _notifyBudget,
                title: "Notify On 10% Budget",
                onChanged: () {},
              ),
              PreferenceSwitchWidget(
                switchValue: _passCode,
                title: "Passcode",
                onChanged: () {},
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Delete My Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
