import 'package:Deprofiz/models/recent_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';


class EmpRecentFiles extends StatelessWidget {
  const EmpRecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Logs",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white, // White text for the title
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text(
                    "Card ID",
                    style: TextStyle(
                        color: Colors.white), // White for column headers
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Dustbin ID",
                    style: TextStyle(
                        color: Colors.white), // White for column headers
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Date",
                    style: TextStyle(
                        color: Colors.white), // White for column headers
                  ),
                ),
              ],
              rows: List.generate(
                demoRecentLogs.length,
                    (index) => recentFileDataRow(demoRecentLogs[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentLog fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Text(
          fileInfo.EmployeeName,
          style: TextStyle(color: Colors.white), // Black text for data cells
        ),
      ),
      DataCell(
        Text(
          fileInfo.dustbinId,
          style: TextStyle(color: Colors.white), // Black text for data cells
        ),
      ),
      DataCell(
        Text(
          fileInfo.getFormattedDate(),
          style: TextStyle(color: Colors.white), // Black text for data cells
        ),
      ),
    ],
  );
}
