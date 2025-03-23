import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapi_sample/common/app_strings.dart';
import 'package:newsapi_sample/providers/connectivity_provider.dart';
import 'package:newsapi_sample/providers/theme_provider.dart';
import 'package:newsapi_sample/providers/top_news_provider.dart';
import 'package:newsapi_sample/repository/top_news_repository_imp.dart';
import 'package:newsapi_sample/screens/home_screen.dart';
import 'package:newsapi_sample/screens/setting_screen.dart';
import 'package:newsapi_sample/services/api_service.dart';
import 'package:provider/provider.dart';

import 'common/widgets/custom_text_widget.dart';
import 'common/widgets/no_connectivity.dart';

void main() async {
  final apiService = ApiService();
  final topNewsRepository = TopNewsRepositoryImp(apiService);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(
          create: (_) => TopNewsProvider(topNewsRepository),
        ),
      ],
      child: const MyApp(),
      // Inject repo into Provider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(), // Pass necessary arguments if needed
      // home: const NativeAdWidget(), // Pass necessary arguments if needed
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [const HomeScreen(), const SettingScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivity, child) {
        if (!connectivity.isOnline) {
          Future.microtask(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const NoConnectivity()),
            );
          });
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
            elevation: 4,
            title: CustomTextWidget(text: AppStrings.appName, fontSize: 18),
          ),
          body: IndexedStack(index: _selectedIndex, children: _screens),
          bottomNavigationBar: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              bool isDark = themeProvider.isDarkMode; // Get current theme mode

              return BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                selectedItemColor: isDark ? Colors.white : Colors.black,
                // Change color in dark mode
                unselectedItemColor: isDark ? Colors.white70 : Colors.black54,
                // Change color in dark mode
                backgroundColor: isDark ? Colors.black : Colors.white,
                // Background color based on theme
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                items: [
                  BottomNavigationBarItem(
                    icon: _buildNavIcon(context, Icons.home, 0),
                    label: AppStrings.home,
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavIcon(context, Icons.settings, 3),
                    label: AppStrings.settings,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildNavIcon(BuildContext context, IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 5, 14, 5),
      decoration:
          isSelected
              ? BoxDecoration(
                color:
                    isDarkMode
                        ? Colors.white24
                        : Colors.black12, // Adaptive color
                borderRadius: BorderRadius.circular(10),
              )
              : null,
      child: Icon(
        icon,
        size: 24,
        color:
            isSelected
                ? (isDarkMode
                    ? Colors.white
                    : Colors.black) // Adaptive icon color
                : (isDarkMode ? Colors.white70 : Colors.black54),
      ),
    );
  }
}
