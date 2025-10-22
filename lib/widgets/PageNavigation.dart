import 'package:flutter/material.dart';
import 'package:foodie_app/constants/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:foodie_app/pages/home.dart';
import 'package:foodie_app/pages/profilePage.dart';
import 'package:foodie_app/pages/HelpPage.dart';
import 'package:foodie_app/pages/favoriteItem.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({super.key});

  @override
  State<PageNavigation> createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> {
  int selectedPage = 0;

  final List<Widget> pages = [
    const Home(),
    const ProfilePage(),
    const HelpPage(),
    const FavoriteItem(),
  ];

  void onPageTapped(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: SalomonBottomBar(
            currentIndex: selectedPage,
            onTap: onPageTapped,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: AppColors.primary,
                // selectedColor: Colors.blue,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text("Profile"),
                selectedColor: AppColors.primary,
                // selectedColor: Colors.green,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.chat),
                title: const Text("Help"),
                // selectedColor: Colors.orange,
                selectedColor: AppColors.primary,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite_border),
                title: const Text("Fovorite"),
                // selectedColor: Colors.purple,
                selectedColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
