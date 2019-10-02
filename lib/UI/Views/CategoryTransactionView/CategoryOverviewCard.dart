import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/MonthProvider.dart';
import '../../Widgets/MonthlyOverview/CategoryCard.dart';
import '../../../Core/Constants/ColorPalette.dart';

class CategoryOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MonthProvider monthData = Provider.of<MonthProvider>(context);
    final List<Map<String, dynamic>> categoryList = monthData.monthlyCategoryTotals;

    return Container(
        child: Column(
      children: <Widget>[
        const Text(
          "Six Week Totals",
          style: TextStyle(fontSize: 28, color: ColorPalette.greyCityLights, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              CategoryCard(
                categoryList[0]["category"],
                categoryList[0]["amount"],
                ColorPalette.redPinkGlamor,
                ColorPalette.tealRobinsEgg,
              ),
              CategoryCard(
                categoryList[1]["category"],
                categoryList[1]["amount"],
                ColorPalette.purpleExodusFruit,
                ColorPalette.pinkPrunusAvium,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              CategoryCard(
                categoryList[2]["category"],
                categoryList[2]["amount"],
                ColorPalette.greenMintLeaf,
                ColorPalette.blueElectron,
              ),
              CategoryCard(
                categoryList[3]["category"],
                categoryList[3]["amount"],
                ColorPalette.redChiGong,
                ColorPalette.orangeville,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              CategoryCard(
                categoryList[4]["category"],
                categoryList[4]["amount"],
                ColorPalette.yellowBrightYarrow,
                ColorPalette.orangeville,
              ),
              CategoryCard(
                categoryList[5]["category"],
                categoryList[5]["amount"],
                ColorPalette.purpleExodusFruit,
                ColorPalette.blueElectron,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              CategoryCard(
                categoryList[6]["category"],
                categoryList[6]["amount"],
                ColorPalette.redChiGong,
                ColorPalette.pinkPrunusAvium,
              ),
              CategoryCard(
                categoryList[7]["category"],
                categoryList[7]["amount"],
                ColorPalette.blueGreyGoodSamaritan,
                ColorPalette.tealRobinsEgg,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
