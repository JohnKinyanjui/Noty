import 'package:flutter/material.dart';
import 'package:noty/ui/pages/main/my_app.dart';
import 'package:noty/utils/themes/decorations.dart';

import '../../../features/connector/connector.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Connector? connector;

  @override
  void initState() {
    super.initState();
    setState(() {
      connector = Connector();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Decorations.bgColor,
      title: 'Noty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashP(connector: connector!),
    );
  }
}

class SplashP extends StatefulWidget {
  final Connector connector;
  const SplashP({Key? key, required this.connector}) : super(key: key);

  @override
  State<SplashP> createState() => _SplashPState();
}

class _SplashPState extends State<SplashP> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(Duration(milliseconds: 3000), () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => MyApp(connector: widget.connector)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Decorations.bgColor1,
      body: Container(
        width: double.infinity,
        color: Decorations.bgColor1,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Scribbler",
                  style: Decorations.style(
                    fontSize: 15,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
