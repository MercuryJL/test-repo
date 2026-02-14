
# Root App Widget Analyzation 
```dart
class SimplePortfolioApp extends StatelessWidget {
   const SimplePortfolioApp({Key? key}) : super(key: key);
}
```
---
**const:** 
   - allowed for reuse of widget without rebuilding, then improving performance, very fit for no changing fields
   - Comparison: 
      - in Roblox Studio, I applied Singleton I learned in 'application developement' subject.
      - singleton ensure one instace are created only, while providing global access point to instance.
      - same concept, different rules

**SimplePortfolioApp({Key? key}**
   - this is the constructor
   - Question:
      - runApp(const SimplePortfolioApp()) - this does not have value, how?, does **key** automatically create a reference?
         - According to chatgpt:
            - {Key? key} = optional named parameter. 
            - if you don’t give it, Dart uses the default value: null.
            - A Key is an identifier Flutter can use when comparing widgets during rebuilds.
            - you don’t need a key here, so null is totally fine.
            - Widget instance = the object you created: SimplePortfolioApp()
            - Key = optional “name tag” you can pin on it so Flutter can recognize it later
            - If you don’t pin a name tag → Flutter can still use it, it just uses structure/type to match it.

**key** 
   - is used for identifaction inside widget tree. This allowed proper referencing of object

**{...}** 
   - named parameters, *Key?* (? mean can be null)
   - parameter from constructor of class 

**super(key: key)**
   - the parameters from consstructor of clas SimplePortfolioApp is also applied to consstructor of class StatelessWidget
   - Comparison:
      - In C# it look like this 
      ```C#
         public class BankAccount {
            public BankAccount (long account, double balance) {
               ...
            }
         }
         public class CheckingAccount : BankAccount {
            public CheckingAccount(long account, double balance) : base(account, balance) {
               ...
            }
         }
      ```
      - Same logic, different visual due to abstraction of flutter

---
```dart
class SimplePortfolioApp extends StatelessWidget {
  const SimplePortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: HomePage(),
    );
  }
}
```

**override**
   - build() method is actually require to be used in StatelessWidget()
   - Comparison:
      - We can compare this to C# and Java OOP of their abstract method, where the inheriting class is required to override.

**What does "Widget" mean in Flutter?**
   - Widget is just a description of UI
   - think of it like a lego
      - Text() is a widget
      - Container() is a widget
      - Scaffold() is a widget
      - Even my HomePage() is a widget
      Everything on screen is built from widgets.
      Its not the actual pixel drawing, but a bluprint flutter use to draw and update the screen.
   - Two types of Widget:
      1. Stateless Widget - UI depends only on input, no changes internally
      2. Stateful Widget - UI change because it has **State**, and changes via State

**What is BuildContext?**
   - A Widget reference / address inside the widget tree. It gives "Where I am in widget tree and my class access inherited method"
   - flutter give my 'Widget build(name)' a reference so we can get it build(name) its access inherited method.
   - Help access to:
      - Theme - Theme.of(context)
      - Screen Size - MediaQuery.of(context).size
      - Navigation - Navigator.of(context).push(...)
      - ScaffoldMessenger.of(context)

**return MaterialApp()**
   - MaterialApp is root of Material Design app.
   - basically saying "my app follows material design rules and has global setting"
   - runApp(), create app -> StatelessWidget-the app is constant become container, Widget(any visual)-Design on Material App -> Every manipulation is inside the Material App
---
# Creating the HomePage Structure 
```dart
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
```
**HomePage Class**
   - This is the configution to MaterialApp(home: ...)
   
**StatefulWidget**
   - This 'home: object-class' is updating base on state.

**const HomePage({Key? key}) : super(key: key)**
   - same logic to my first explanation, Key? can be null or contain value, and will be send to parent class StatefulWidget constructor

**State< HomePage > createState() => _HomePageState();**
   - Similar to abstraction, this is required for inheriting StatefulWidget
   - The core of StatefulWidget
   - When we put HomePage in widget tree, a seperate object will store the changing data.
   - State< HomePage > the state is specific for HomePage widget type.
   - _HomePageState() the one who will contain the actual class such as:
      - variables (like counters, selected index, text input)
      - build() for UI
      - lifecycle method like initState(), dispose()
      this is seperated because flutter wants:
         - Widget to be lightweight and immmutable (easy to compare)
         - State to be where changes happen

---
```dart
class _HomePageState extends State<HomePage> {
  String selectedPage = 'Home';
  late ScrollController _scrollController;
  
  // We'll add more code here
}
```
- this is the State object that belong to HomePage Class
- this require abstract:  
   - build()
   - initState
   - dispose

**underscore '_'**
 - this class is private

**String selectedPage = 'Home'**
   - this will be use in state variable
   - example drawer buttons set to "About" or "Projects"
   - we must use 
   ```dart
   setState(() {
      selectedPage = 'About';
   });
   ```
   - without this, variable change in memory, but the screen won't rebuild.

**late ScrollController _scrollController;**
   - This is for controlling / listening to a scrollable widget like:
      - ListView
      - SingleChildView
      - CustomeScrollView
   - this will tell the current scroll position
   - let us scrol programmatically (jump/animate)
   - let us detect when user reached bottom/top etc.
   - **late** mean we promise to computer we will initialize it before used, why?
      - we usually initialize **controllers** inside initState()
      - because if we use _scrollController beofre assigning it, it result to error

---
```dart
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
```
- the life cycle part of **State**
- create resources -> clean resources

**initState()**
   - this run once when created and inserted into widget tree.
   - similar to main method when program runs, it's the first method to run.
   - why **super.initState()** first?
      - so flutter State class can do its own setup before I add my setup (**ALWAYS DO THIS!!!**)
   - **_scrollController = ScrollController();**
      - the **late** initialization, make it attach here safely
      - Now I can safely attach _scrollController later to **SingleChildScrollView(control: _scrollController, ...)**
   - this is where we typically:
      - start listeners (_scrollController.addListener())
      - start one-time loads(fetch data)
      - set initial values

**dispose()**
   - run **once** when this page is being removed permanently from the tree
   - **_scrollController.dispose()**
      - This is very important: it releases listeners/resources
      - If i don't dispose controllers, i can get:
         - memory leaks
         - "used after dispose" errors
         - unnecessary listeners still runnning
   - **Why super.dispose() last?**
      so I clean up my resources first, then let flutter finish tearing down the State.

**In short**
   - **initState()** = plug in / turn on
   - **dispose()** = unplug / turn off

---
# Building the App Bar
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFF5F5F5),
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
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    // We'll add drawer and body next
  );
}
```
- similar explanation to Widget build (BuildContext context), context is location handler in widget tree

**Scaffold(...)**
   - the basic Material "page layout":
      - appBar(top bar)
      - drawer (side menu)
      - body (main content)
      - floatingActionButton, etc
   - I already define the ScaffoldBackgroundColor in MaterialApp(theme: ...), so this will overrides that for this specific page
   - this is similar to frame in Roblox Studio, but has built-in method to define
   - **appBar: AppBar(...)**
      - Top bar.
      - title: Text("Portfolio", style: GoogleFonts.poppins(...))
      just styling the title using Google Fonts.
      - The important part: **leading: Builder(...)**
         - tricky, but when I get it, the BuildContext become crystal clear.
         - why use **Builder** here?
            - Because this line
               ```dart
                  Scaffold.of(context).openDrawer();
               ```
            - this need  **context** which is under the **Scaffold** in widget tree.
            - when we type context, we read the context that is last read which is the builder inside Scaffold.
            - if we did not use builder inside the scaffold we will get error.
         - what **Builder** does?
            - Builder creates a new mini-context that is inside Scaffold's widget tree.
            - so inside:
               '''dart
                  builder: (BuildContext context) { ... }
               '''
               - that context from builder inside scaffold are reference now.
               - and now when this is called, this works:
                  ```dart
                  Scaffold.of(context).openDrawer();
                  ```
               - which is literally different address from context of Scaffold.
         - **IconButton and openDrawer()**
            - this icon and open drawer.
               ```dart
               onPressed: () {
                  Scaffold.of(context).openDrawer();
               }
               ```
            - but this will only work if I made to scaffold later:
               ```dart
               drawer: Drawer(...)
               ```
---
# Creating the Navigation Drawer
```dart
drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      // We'll add DrawerHeader and menu items here
    ],
  ),
),
```
**drawer: Drawer(..)**
   - built-in method in scaffold
   - attaches a left-side slide menu to Scaffold
   - when swipe from left edge, it open.
   - when menu is press and call openDrawer(), it opens.

**child: ListView(...)**
   - inside the drawer, we're using a **ListViewe** because:
      - drawers often have **many menu items**
      - allows scrolling automatically if items don't fit vertically.

**padding: EdgeInsets.zero**
   - By default, **ListView** adds top padding (especially because of status bar / safe are behavior).
   - Setting to zero makes the drawer conotent start exactly at the top

**children: []**
   - This will be your menu content:
      - usually a **DrawerHeader** at the top
      - then **ListTile**s for Home/About/Projects/Contact, etc.

How this connects to your **selectedPage**
   - Soon I will do something like
      ```dart
      ListTile(
         title: Text("about"),
         onTap: () {
            setState(() => selectedPage = 'about');
            Navigator.pop(context); // closes the drawer
         }
      )
      ```
   - **setState** changes page selection, if not set then it will not change anything in screen.
   - **Navigator.pop(context)** closes the drawer because drawer opening is basically a route on the Navigation stack.

---
# Create a Drawer Header
```dart
DrawerHeader(
  decoration: BoxDecoration(
    color: Colors.blue,
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        'Your Name',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 4),
      Text(
        'Flutter Developer',
        style: GoogleFonts.roboto(
          fontSize: 14,
          color: Colors.white70,
        ),
      ),
    ],
  ),
),
```

**DrawHeader**
   - special widget meant for the top section of a Drawer
   - automatically gives me a nice height and spacing that looks "drawer-like"

**decoration: BoxDecoration(color: Colors.blue)**
   - Paints the header background

**child: Column(...)**
   - stacking a texts vertically.
      - **crossAxisAlignment: CrossAxisAlignment.start**
         - left-align everything horizontally (start of the column)
      - **mainAxisAlignment: MainAxisAlignment.end**
         - push content down to the bottom of the header (so it looks like a "profile card" footer)

**Inside children:**
   - First is Text('My name', ...) big + bold += white
   - SizedBox(height: 4) adds a small vertical gap
   - Second Text("Flutter developer"...) smaller + color something semitransparent


