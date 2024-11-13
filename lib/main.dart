import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liquid Swipe Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: LiquidSwipeExample(),
    );
  }
}

class LiquidSwipeExample extends StatefulWidget {
  @override
  _LiquidSwipeExampleState createState() => _LiquidSwipeExampleState();
}

class _LiquidSwipeExampleState extends State<LiquidSwipeExample> {
  int currentPage = 0;
  late LiquidController liquidController;

  final pages = [
    PageData(
      color: Color(0xFF7371FC),
      title: "Welcome",
      subtitle: "To Liquid Swipe",
      description: "Discover a new way to navigate",
      imageUrl: "W.jpeg",
    ),
    PageData(
      color: Color(0xFFFF7D90),
      title: "Explore",
      subtitle: "Amazing Features",
      description: "Smooth transitions and animations",
      imageUrl: "img.jpeg",
    ),
    PageData(
      color: Color(0xFF44B2AE),
      title: "Create",
      subtitle: "Your Journey",
      description: "Start building something amazing",
      imageUrl: "W.jpeg",
    ),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages.map((page) => buildPage(page)).toList(),
            enableLoop: true,
            fullTransitionValue: 880,
            enableSideReveal: true,
            liquidController: liquidController,
            slideIconWidget: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            waveType: WaveType.liquidReveal,
            onPageChangeCallback: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => buildDot(index),
                  ),
                ),
                SizedBox(height: 20),
                if (currentPage != pages.length - 1)
                  TextButton(
                    onPressed: () {
                      liquidController.animateToPage(
                        page: pages.length - 1,
                        duration: 700,
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget buildPage(PageData page) {
    return Container(
      color: page.color,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              page.imageUrl,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 40),
          Text(
            page.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            page.subtitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            page.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class PageData {
  final Color color;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  PageData({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });
}