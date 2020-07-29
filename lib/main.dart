import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(primarySwatch: Colors.red,fontFamily: 'Lobster'),
    home: new MyHomePage()));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  TabController tb;
  double age = 0.0;
  var selectedYear;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    animation = animationController;
    tb = TabController(
      length: 2,
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  void _showPicker() {
    showDatePicker(
        context: context,
        firstDate: new DateTime(1900),
        initialDate: new DateTime(2018),
        lastDate: DateTime.now()).then((DateTime dt) {
      selectedYear = dt.year;
      calculateAge();
    });
  }

  void calculateAge() {
    setState(() {
      age = (2020 - selectedYear).toDouble();
      animation = new Tween<double>(begin: animation.value, end: age).animate(
          new CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: animationController));

      animationController.forward(from: 0.0);
    });
  }

  Widget ageCalcu(){
    return new Scaffold(


      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new OutlineButton(
              child: new Text(selectedYear != null
                  ? selectedYear.toString()
                  : "Select your year of birth"),
              borderSide: new BorderSide(color: Colors.black, width: 3.0),
              color: Colors.white,
              onPressed: _showPicker,
            ),
            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            new AnimatedBuilder(
              animation: animation,
              builder: (context, child) => new Text(
                "Your Age is ${animation.value.toStringAsFixed(0)}",
                style: new TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'IndieFlower',
                ),

              ),
            )
          ],
        ),
      ),
    );

  }

  int firnum;
  int secondnum;
  String texttodisplay = "";
  String res;
  String operationtoperform;

  void btnclicked(String btntext){
    if(btntext == "C"){
      texttodisplay ="";
      firnum =0;
      secondnum =0;
      res = "";
    }else if(btntext =="+" || btntext=="-" ||btntext=="X" || btntext =="/"){
      firnum = int.parse(texttodisplay);
      res = "";
      operationtoperform = btntext;
    }else if(btntext == "="){
      secondnum = int.parse(texttodisplay);
      if(operationtoperform == "+"){
        res = (firnum + secondnum).toString();
      }
      if(operationtoperform == "-"){
        res = (firnum - secondnum).toString();
      }
      if(operationtoperform == "X"){
        res = (firnum * secondnum).toString();
      }
      if(operationtoperform == "/"){
        res = (firnum ~/secondnum).toString();
      }
    }else{
      res = int.parse(texttodisplay+ btntext).toString();
    }

    setState(() {
      texttodisplay = res;
    });
  }

  Widget customButton(String btnVal){
    return Expanded(

        child:OutlineButton(
          onPressed: () => btnclicked(btnVal),

          padding: EdgeInsets.all(25.0),
          child:Text(
              "$btnVal",
            style: TextStyle(
              fontSize: 30.0,





            ),
          ),
        )
    );
  }
  Widget Calcu(){
  return Scaffold(
    
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child:Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.bottomRight,
                child:Text(
                  "$texttodisplay",
                  style:TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                customButton("9"),
                customButton("8"),
                customButton("7"),
                customButton("+"),

              ],
            ),
            Row(
              children: <Widget>[
                customButton("6"),
                customButton("5"),
                customButton("4"),
                customButton("-"),

              ],
            ),
            Row(
              children: <Widget>[
                customButton("3"),
                customButton("2"),
                customButton("1"),
                customButton("X"),

              ],
            ),
            Row(
              children: <Widget>[
                customButton("C"),
                customButton("0"),
                customButton("="),
                customButton("/"),

              ],
            ),
          ],
        ),
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Let's Measure It"),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text('Age Calculator'),
            Text('Calculator'),
          ],
          labelPadding: EdgeInsets.only(bottom: 10.0),
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Colors.white60,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          ageCalcu(),
          Calcu(),
        ],
        controller: tb,
      ),
    );
  }
}