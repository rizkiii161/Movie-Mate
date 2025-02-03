// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movieslist/services/constans.dart';
import 'package:movieslist/views/my_app_home_screen.dart';
import 'package:movieslist/views/my_movies_screen.dart';


class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});
  @override
  _AppMainScreenState createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  late final List<Widget> page;
  @override
  void initState() {
    page = [
      MyAppHomeScreen(),
      // MyMoviesScreen(),
      navBarPage(Iconsax.star5),
      navBarPage(Iconsax.star5),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28,
        currentIndex: selectedIndex,
        selectedItemColor: Kprimarycolor,
        unselectedItemColor: const Color.fromARGB(255, 46, 38, 38),
        selectedLabelStyle: TextStyle(
          color: const Color.fromARGB(255, 65, 181, 220),
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [

        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
           selectedIndex == 1 ? Iconsax.video5 : Iconsax.video_add,
          ),
          label: "My Movies",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 2 ? Iconsax.user : Iconsax.user_add,
          ),
          label: "profile",
        ),
      ]),
      appBar: AppBar(
        title: Text('App Main Screen'),
      ),
      body: page[selectedIndex],
    );
  }
  navBarPage(iconName){
    return Center(
      child: Icon(
        iconName,
        size:100 ,
        color: Kprimarycolor,
        ),
    );
  }
}
