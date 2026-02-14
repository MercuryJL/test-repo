import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const SimplePortfolioApp());
}

class SimplePortfolioApp extends StatelessWidget {
  const SimplePortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Portfolio",
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedPage = "Home";
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildContent() {
    if (selectedPage == "Home") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'lib/assets/images/profile.jpeg', 
              width: 120, 
              height: 120, 
              fit: BoxFit.cover
            ),
          ),
          SizedBox(height: 16),
          Text(
            "John Lloyd Ducoy",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade700,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Flutter Developer | Computer Science Student",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade500,
            ),
          ),
        ],
      );
    }
    return Text("Coming soon: $selectedPage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'Portfolio',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber.shade50
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "John Lloyd Ducoy",
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "BS Computer Science",
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.amber.shade400,
                    ),
                  ),
                ], 
              ),
            ), 
            ListTile(
              leading: Icon(Icons.home, color: Colors.amber.shade700),
              title: Text(
                "Home",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber.shade700,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.amber.shade700),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedPage = "Home";
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.amber.shade700),
              title: Text(
                "About",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber.shade700,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedPage = "About";
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb, color: Colors.amber.shade700),
              title: Text(
                "Skills",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber.shade700,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedPage = "Skills";
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.amber.shade700),
              title: Text(
                "Contact",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber.shade700,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedPage = "Contact";
                });
              },
            ),
            Divider(color: Colors.amber.shade200, thickness: 1, indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(Icons.download, color: Colors.amber.shade700),
              title: Text (
                "Download CV",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber.shade700,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                print("Download CV clicked");
              }
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: _buildContent(),
          ),
        ),
      ),
    );
  }










}

