import 'package:flutter/material.dart';
import 'package:theater_frontend/widgets/side_menu_widget.dart';

import '../utils/responsive.dart';
import 'custom_footer.dart';

class BaseLayout extends StatelessWidget {
  final Widget mainContent;
  final Widget? sideMenu;
  final Widget? customFooter;

  const BaseLayout({
    Key? key,
    required this.mainContent,
    this.sideMenu,
    this.customFooter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: Text("App Title"), // Puoi personalizzare questo titolo
        leading: !isDesktop ? Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ) : null,
      ),
      drawer: !isDesktop
          ? (sideMenu ?? const SizedBox(width: 250, child: SideMenuWidget()))
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              Expanded(
                flex: 2,
                child: sideMenu ?? SizedBox(child: SideMenuWidget()),
              ),
            Expanded(
              flex: 7,
              child: mainContent,
            ),
          ],
        ),
      ),
      bottomNavigationBar: customFooter ?? CustomFooter(),
    );
  }
}
