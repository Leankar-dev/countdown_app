import 'dart:developer';

import 'package:flutter/material.dart';

import '../core/countdown/countdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final CountdownController countdownController;
  var enableResendSMSButton = false;
  // var enableResetButton = false;

  @override
  void initState() {
    countdownController = CountdownController(
      duration: Duration(seconds: 15),
      onEnd: () {
        log('Countdown finished!');
        setState(() {
          enableResendSMSButton = true;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COUNTDOWN TIMER'),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent[100],
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          spacing: 20,
          children: [
            const SizedBox(height: 20),
            CountdownWidget(
              textStyle: TextStyle(fontSize: 30),
              controller: countdownController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      countdownController.restart();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed:
                      enableResendSMSButton
                          ? () {
                            setState(() {
                              enableResendSMSButton = false;
                              countdownController.restart();
                            });
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Resend SMS'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
