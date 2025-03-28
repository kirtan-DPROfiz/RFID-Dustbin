
import 'package:Deprofiz/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'component/empHeader.dart';
import 'component/empRecentFile.dart';


class EmpDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        // primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            EmpHeader(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      EmpRecentFiles(),


                      /*if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StorageDetails(),*/
                    ],
                  ),
                ),
                /*  if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),*/
              ],
            )
          ],
        ),
      ),
    );
  }
}
