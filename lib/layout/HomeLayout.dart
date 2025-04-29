import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.homeBottomScreens[cubit.homeCurrentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SlidingClippedNavBar(
              backgroundColor: Colors.white,
              onButtonPressed: (index) {
                cubit.homeChangeBottom(index);
              },
              iconSize: 30,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).primaryColor,
              selectedIndex: cubit.homeCurrentIndex,
              barItems: [
                BarItem(
                  icon: Iconsax.home_2,
                  title: 'Home',
                ),
                BarItem(
                  icon: Iconsax.user,
                  title: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
