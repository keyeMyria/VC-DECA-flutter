import 'package:flutter/material.dart';
import 'package:vc_deca/register_page.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}


class _OnboardingPageState extends State<OnboardingPage> {

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        OnboardingOne(),
        OnboardingTwo(),
        OnboardingThree(),
        RegisterPage()
      ],
    );
  }
}

final headingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none
);

class OnboardingOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 64.0),
      color: Colors.blue,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Text(
            "Welcome to the Valley Christian DECA App!",
            textAlign: TextAlign.center,
            style: headingTextStyle,
          ),
          new FlatButton(
            onPressed: () {
            },
            child: new Text(
              "Skip",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      )
    );
  }
}

class OnboardingTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
    );
  }
}

class OnboardingThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
    );
  }
}


