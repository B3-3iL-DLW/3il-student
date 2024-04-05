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
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: body,
                ),
                if (bottomContent != null)
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                    // 20% of screen height
                    child: bottomContent,
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
