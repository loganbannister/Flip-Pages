import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

//import 'package:flutter/material.dart';
//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/Fr_Elise.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/Canon_in_D.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromAsset('assets/Carol_of_the_Bells.pdf');
    } else {
      document = await PDFDocument.fromAsset('assets/Fr_Elise.pdf');
    }
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(height: 36),
            ListTile(
              title: Text('Canon in D'),
              onTap: () {
                changePDF(1);
              },
            ),
            ListTile(
              title: Text('Carol of the Bells'),
              onTap: () {
                changePDF(2);
              },
            ),
            ListTile(
              title: Text('Fur Elise'),
              onTap: () {
                changePDF(3);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('FlipPages'),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
          document: document,
          zoomSteps: 1,
          //uncomment below line to preload all pages
           lazyLoad: false,
          // uncomment below line to scroll vertically
          // scrollDirection: Axis.vertical,

          //uncomment below code to replace bottom navigation with your own
          /* navigationBuilder:
                          (context, page, totalPages, jumpToPage, animateToPage) {
                        return ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.first_page),
                              onPressed: () {
                                jumpToPage()(page: 0);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                animateToPage(page: page - 2);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                animateToPage(page: page);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.last_page),
                              onPressed: () {
                                jumpToPage(page: totalPages - 1);
                              },
                            ),
                          ],
                        );
                      }, */
        ),
      ),
    );
  }
}

/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipPages',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlipPages'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Image(
              image: AssetImage('assets/IMG_0506 2.PNG')
            ),
            Text('FlipPages'),
          ],
        ),
      ),
    );
  }
}
*/