import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/dashboard/presentation/dashboard/dashboard_cubit.dart';
import 'package:recipe/feature/home/presentation/screen/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    ///
    /// Upcoming screen will
    ///  be here 
    /// 
  ];
  void onTabChanged(int i) => context.read<DashboardCubit>().onTap(i);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state, children: _screens),
          ///!! comment this because there is no need for bottom nav
          // bottomNavigationBar: Padding(
          //   key: const ValueKey("dashBoard_bottom_nav"),
          //   padding: EdgeInsets.fromLTRB(
          //     12,
          //     12,
          //     12,
          //     MediaQuery.viewPaddingOf(context).bottom + 10,
          //   ),
          //   child: GNav(
          //     selectedIndex: state,
          //     backgroundColor: context.scaffoldBackgroundColor,
          //     onTabChange: onTabChanged,
          //     rippleColor: context.splashColor,
          //     tabBorderRadius: 12,
          //     curve: Curves.easeIn,
          //     duration: const Duration(milliseconds: 200),
          //     gap: 8,
          //     color: context.disabledColor,
          //     activeColor: context.onPrimary,
          //     iconSize: 26,
          //     tabBackgroundColor: context.primaryColor,
          //     padding: const EdgeInsets.all(5),
          //     textStyle: context.bodyLarge?.copyWith(
          //       color: context.onPrimary,
          //       fontWeight: FontWeight.w600,
          //     ),
          //     tabs: const [
          //       GButton(icon: Icons.home, text: 'Home'),
          //       GButton(icon: Icons.favorite, text: 'Likes'),
          //       GButton(icon: Icons.search, text: 'Search'),
          //       GButton(icon: Icons.person, text: 'Profile'),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
