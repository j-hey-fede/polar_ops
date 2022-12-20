import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:polar_ops/home/home_screen.dart';
import 'package:polar_ops/provider/card_provider.dart';
import 'package:polar_ops/widget/logo_row_words.dart';
import 'package:polar_ops/widget/tinder_card.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Tinder Clone';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CardProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home: HomeScreen(),
          theme: ThemeData(
            primarySwatch: Colors.red,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 32),
                elevation: 8,
                primary: Colors.white,
                shape: CircleBorder(),
                minimumSize: Size.square(80),
              ),
            ),
          ),
        ),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 210, 214, 210),
              Color.fromARGB(255, 13, 112, 16),
              Color.fromARGB(255, 127, 20, 20),
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: LogoRowWords(),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  size: 34,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => HomeScreen()));
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(child: buildCards()),
                  const SizedBox(height: 16),
                  buildButtons(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final children = provider.children;

    return children.isEmpty
        ? Center(
            child: Text(
              'GO SLEIGH, SANTA!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        : Stack(
            children: children
                .map((child) => TinderCard(
                      child: child,
                      isFront: children.last == child,
                    ))
                .toList(),
          );
  }

  Widget buildButtons() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.children;
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;

    return users.isEmpty
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Restart',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              final provider =
                  Provider.of<CardProvider>(context, listen: false);

              provider.resetUsers();
            },
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      getColor(Colors.red, Colors.white, isDislike),
                  backgroundColor:
                      getColor(Colors.white, Colors.red, isDislike),
                  side: getBorder(Colors.red, Colors.white, isDislike),
                ),
                child: Icon(Icons.clear, size: 46),
                onPressed: () {
                  final provider =
                      Provider.of<CardProvider>(context, listen: false);

                  provider.dislike();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      getColor(Colors.grey, Colors.white, isSuperLike),
                  backgroundColor:
                      getColor(Colors.white, Colors.grey, isSuperLike),
                  side: getBorder(Colors.grey, Colors.white, isSuperLike),
                ),
                child: Icon(Icons.question_mark, size: 40),
                onPressed: () {
                  final provider =
                      Provider.of<CardProvider>(context, listen: false);

                  provider.superLike();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: getColor(Colors.teal, Colors.white, isLike),
                  backgroundColor: getColor(Colors.white, Colors.teal, isLike),
                  side: getBorder(Colors.teal, Colors.white, isLike),
                ),
                child: Icon(Icons.check, size: 40),
                onPressed: () {
                  final provider =
                      Provider.of<CardProvider>(context, listen: false);

                  provider.like();
                },
              ),
            ],
          );
  }

  MaterialStateProperty<Color> getColor(
      Color color, Color colorPressed, bool force) {
    final getColor = (Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };

    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(
      Color color, Color colorPressed, bool force) {
    final getBorder = (Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return BorderSide(color: Colors.transparent);
      } else {
        return BorderSide(color: color, width: 2);
      }
    };

    return MaterialStateProperty.resolveWith(getBorder);
  }
}
