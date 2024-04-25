import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomContent;
  final Widget? bottomBar;

  const CustomLayout({
    super.key,
    this.appBar,
    required this.body,
    this.bottomContent,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      body,
                      if (bottomContent != null)
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3),
                    ],
                  ),
                ),
                if (bottomContent != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: bottomContent!,
                  ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}
