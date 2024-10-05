import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name', // You can add a title for your app
      debugShowCheckedModeBanner: false, // Hide the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define your app's primary color
      ),
      home: const Testing(), // Ensure Testing() is a constant widget
    );
  }
}

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Show Modal"),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const NoEmailRewards(); // Ensure NoEmailRewards is constant
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NoEmailRewards extends StatelessWidget {
  const NoEmailRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset('assets/images/empty_Emails.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Oops. Found Nothing!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 16, // Set font size directly
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontSize: 14, // Set font size directly
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            "We couldn't find any emails related to the shop. Try another method.",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 8.0, // Adjust the positioning as needed
          top: 8.0, // Adjust the positioning as needed
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the modal
            },
            child: const Icon(
              Icons.close, // Cross button
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
