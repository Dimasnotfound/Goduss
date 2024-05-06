import 'package:flutter/material.dart';
import 'rekap_screen.dart';
import 'tracking_screen.dart';
import 'akun_screen.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class LandingPageScreen extends StatefulWidget {
  final int userId;
  final double? latitude;
  final double? longitude;

  const LandingPageScreen({
    Key? key,
    required this.userId,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  final _pageController = PageController(initialPage: 1);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 1);

  int maxCount = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  List<Widget> get bottomBarPages => [
        RekapScreen(userId: widget.userId),
        TrackingScreen(
          userId: widget.userId,
          latitude: widget.latitude,
          longitude: widget.longitude,
        ),
        AkunScreen(userId: widget.userId),
      ]; // in/ index halaman tracking

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(33, 92, 168, 1),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.asset(
                'assets/goatjumping.png',
                width: 20,
                height: 32,
              ),
            ),
            const Expanded(
              child: Text(
                'GO-DUS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Color.fromRGBO(33, 92, 168, 1),
              showLabel: false,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: Color.fromRGBO(33, 92, 168, 1),

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,
              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                  itemLabel: 'Rekap',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  itemLabel: 'Tracking',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  itemLabel: 'Akun',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                print('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}

//   Widget _getPage(int index) {
//     switch (index) {
//       case 0:
//         return RekapScreen(userId: widget.userId);
//       case 1:
//         return TrackingScreen(
//           userId: widget.userId,
//           latitude: widget.latitude,
//           longitude: widget.longitude,
//         );
//       case 2:
//         return AkunScreen(userId: widget.userId);
//       default:
//         return Container();
//     }
//   }
// }
