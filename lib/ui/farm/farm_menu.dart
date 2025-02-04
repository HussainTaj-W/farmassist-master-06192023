import 'package:farmassist/app_theme.dart';
import 'package:farmassist/ui/farm/harvesting/harvesting_menu.dart';
import 'package:farmassist/ui/farm/news/news_home.dart';
import 'package:farmassist/ui/farm/planting/planting_menu.dart';
import 'package:farmassist/ui/farm/statistics/statistics_home.dart';
import 'package:farmassist/ui/farm/weather/weatherHome.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:page_transition/page_transition.dart';

class FarmMenu extends StatefulWidget {
  @override
  _FarmMenuState createState() => _FarmMenuState();
}

class _FarmMenuState extends State<FarmMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherHome(),
        GFListTile(
          avatar: GFAvatar(
            backgroundImage: AssetImage('assets/images/manage_planting.png'),
            backgroundColor: GFColors.TRANSPARENT,
          ),
          titleText: 'Planting',
          subTitle: Text('Store and view planting related activities.'),
          color: Colors.blue[100],
          icon: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(type: PageTransitionType.leftToRightWithFade, child: PlantingMenu()),
            );
          },
        ),
        GFListTile(
          avatar: GFAvatar(
            backgroundImage: AssetImage('assets/images/manage_harvest.png'),
            backgroundColor: GFColors.TRANSPARENT,
          ),
          titleText: 'Harvesting',
          color: Colors.blueAccent[100],
          subTitle: Text('Store and view planting related activities.'),
          icon: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(type: PageTransitionType.leftToRightWithFade, child: HarvestMenu()),
            );
          },
        ),
        GFListTile(
          avatar: GFAvatar(
            backgroundImage: AssetImage('assets/images/manage_news.png'),
            backgroundColor: GFColors.TRANSPARENT,
          ),
          titleText: 'View News',
          color: Colors.lightBlue[100],
          subTitle: Text('Store and view planting related activities.'),
          icon: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(type: PageTransitionType.leftToRightWithFade, child: HomePage()),
            );
          },
        ),
        GFListTile(
          avatar: GFAvatar(
            backgroundImage: AssetImage('assets/images/manage_statistics.png'),
            backgroundColor: GFColors.TRANSPARENT,
          ),
          titleText: 'View Statistics',
          subTitle: Text('Store and view planting related activities.'),
          color: Colors.lightBlueAccent[100],
          icon: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRightWithFade, child: StatisticsHome()),
            );
          },
        ),
      ],
    );
  }
}
