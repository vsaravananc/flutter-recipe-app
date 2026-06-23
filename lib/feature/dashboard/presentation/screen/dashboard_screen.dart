import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/feature/dashboard/presentation/dashboard/dashboard_cubit.dart';
import 'package:recipe/feature/home/presentation/screen/home_screen.dart';
import 'package:recipe/feature/scanner/presentation/screen/scanner_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();
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

          bottomNavigationBar: BottomNavigationBar(
            elevation: 2,
            currentIndex: state,
            onTap: (value) => switch (value) {
              0 => onTabChanged(value),
              _ => showModalBottomSheet(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                useSafeArea: true,
                enableDrag: false,
                context: context,
                builder: (c) => DraggableScrollableSheet(
                  controller: _draggableScrollableController,
                  initialChildSize: 0.5,
                  maxChildSize: 1,
                  expand: false,
                  minChildSize: 0.5,
                  snap: true,
                  snapSizes: [0.55,1],
                  builder: (context, scrollController) => ScannerScreen(
                    controller: _draggableScrollableController,
                    scrollController: scrollController,
                  ),
                ),
              ),
            },

            items: [
              const BottomNavigationBarItem(
                icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: HugeIcon(icon: HugeIcons.strokeRoundedBarcodeScan),
                label: 'Scanner',
              ),
            ],
          ),
        );
      },
    );
  }
}
