import 'package:flutter/material.dart';
import 'package:projectest/models/NewArticle.dart';
import 'package:projectest/screen/search.dart';
import 'package:projectest/services/WebService.dart';
import 'package:projectest/utils/constants.dart';
import 'package:projectest/widgets/NewsListViewModel.dart';
import 'package:projectest/widgets/NewsViewModel.dart';
import 'package:projectest/widgets/newsList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  final VoidCallback signOut;
  HomeScreen(this.signOut);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  List<NewsArticle> _newsArticles = List<NewsArticle>();
  signOut() {
    setState(() {
      widget.signOut();
    });
  }


  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    _populateNewsArticles();
  }
  void _populateNewsArticles() {

    Webservice().load(NewsArticle.all).then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });

  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: _newsArticles[index].urlToImage == null ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) : Image.network(_newsArticles[index].urlToImage),
      subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: DrawerHeader(
                child: Text(
                  "Side Bar",
                   style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/2.jfif'))),
              ),
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Search'),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => NewsListPage()))},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => signOut(),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("NEW MOTHERFUCKER"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.lock_open),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _newsArticles.length,
        itemBuilder: _buildItemsForListView,
      ),
    );
  }
}