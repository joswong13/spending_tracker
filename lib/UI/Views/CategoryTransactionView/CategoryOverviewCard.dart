import 'package:first_flutter/Core/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/MonthProvider.dart';
import '../../Widgets/MonthlyOverview/CategoryCard.dart';
import '../../../Core/Constants/ColorPalette.dart';

class CategoryOverviewCard extends StatelessWidget {
  final SizeConfig sizeConfig = SizeConfig();
  @override
  Widget build(BuildContext context) {
    final MonthProvider monthData = Provider.of<MonthProvider>(context);
    final List<Map<String, dynamic>> categoryList = monthData.monthlyCategoryTotals;

    return Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Column(
          children: <Widget>[
            Text(
              "Six Week Totals",
              style: TextStyle(fontSize: sizeConfig.topHeight28, color: greyCityLights, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  CategoryCard(
                    categoryList[0]["category"],
                    0,
                    //categoryList[0]["amount"],
                    redPinkGlamor,
                    tealRobinsEgg,
                  ),
                  CategoryCard(
                    categoryList[1]["category"],
                    1,
                    //categoryList[1]["amount"],
                    purpleExodusFruit,
                    pinkPrunusAvium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  CategoryCard(
                    categoryList[2]["category"],
                    2,
                    //categoryList[2]["amount"],
                    greenMintLeaf,
                    blueElectron,
                  ),
                  CategoryCard(
                    categoryList[3]["category"],
                    3,
                    //categoryList[3]["amount"],
                    redChiGong,
                    orangeville,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  CategoryCard(
                    categoryList[4]["category"],
                    4,
                    //categoryList[4]["amount"],
                    yellowBrightYarrow,
                    orangeville,
                  ),
                  CategoryCard(
                    categoryList[5]["category"],
                    5,
                    //categoryList[5]["amount"],
                    purpleExodusFruit,
                    blueElectron,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  CategoryCard(
                    categoryList[6]["category"],
                    6,
                    //categoryList[6]["amount"],
                    redChiGong,
                    pinkPrunusAvium,
                  ),
                  CategoryCard(
                    categoryList[7]["category"],
                    7,
                    //categoryList[7]["amount"],
                    blueGreyGoodSamaritan,
                    tealRobinsEgg,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
