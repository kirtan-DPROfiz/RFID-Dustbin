import 'package:Deprofiz/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../res/routes/routes_name.dart';

class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/DprofizLogo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            routeName: RouteNames.dashboardScreen,
          ),
          DrawerListTile(
            title: "Dustbin",
            svgSrc: "assets/icons/menu_store.svg",
            routeName: RouteNames.dustbinPage,
          ),
          DrawerListTile(
            title: "Employee",
            svgSrc: "assets/icons/menu_task.svg",
            routeName: RouteNames.employeePage,
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            routeName: RouteNames.profilePageScreen,
          ),
          /*
          DrawerListTile(
            title: "Export Data",
            svgSrc: "assets/icons/menu_tran.svg",
            routeName: RouteNames.exportDataScreen,
          ),
          DrawerListTile(
            title: "Audit",
            svgSrc: "assets/icons/menu_doc.svg",
            routeName: RouteNames.auditPageScreen,
          ),
          DrawerListTile(
            title: "Logs",
            svgSrc: "assets/icons/menu_notification.svg",
            routeName: RouteNames.logsPageScreen,
          ),
          DrawerListTile(
            title: "Assign Dustbin",
            svgSrc: "assets/icons/menu_doc.svg",
            routeName: RouteNames.AccessListDustbinScreen,
          ),*/

          /* Uncomment when settings is available
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            routeName: RouteNames.settingPageScreen,
          ),
          */
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.routeName,
  }) : super(key: key);

  final String title, svgSrc, routeName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (ModalRoute.of(context)?.settings.name != routeName) {
          Navigator.pushNamed(context, routeName);
        } else {
          Navigator.pop(context); // Close drawer if already on the screen
        }
      },
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
