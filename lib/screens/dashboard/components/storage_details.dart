import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
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
            "Dustbins Usage",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/menu_store.svg",
            title: "Dustbins 1",
            amountOfDust: "10",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/menu_store.svg",
            title: "Dustbins 2",
            amountOfDust: "19",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/menu_store.svg",
            title: "Dustbins 3",
            amountOfDust: "26",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/menu_store.svg",
            title: "Dustbins 4",
            amountOfDust: "38",
            numOfFiles: 140,
          ),
        ],
      ),
    );
  }
}
