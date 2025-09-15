import 'package:dio_log_viewer/src/widget/custom_tab_indicator.dart';

import './error_page.dart';
import './request_page.dart';
import './response_page.dart';
import './try_again_page.dart';
import '../entity/result_entity.dart';
import 'package:flutter/material.dart';

class LogDetail extends StatefulWidget {
  final ResultEntity entity;

  const LogDetail({super.key, required this.entity});

  @override
  State<LogDetail> createState() => _LogDetailState();
}

class _LogDetailState extends State<LogDetail> with SingleTickerProviderStateMixin {
  String title = 'Request';

  late final TabController _tabController = TabController(length: 4, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    switch (_tabController.index) {
      case 0:
        title = 'Request';
        break;
      case 1:
        title = 'Response';
        break;
      case 2:
        title = 'Error';
        break;
      case 3:
        title = 'TryAgain';
        break;
      default:
        title = 'Detail';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: TabBarView(controller: _tabController, children: [
          RequestPage(widget.entity.options, widget.entity.startTime!, widget.entity.endTime),
          ResponsePage(widget.entity.response),
          ErrorPage(widget.entity.err),
          TryAgainPage(widget.entity)
        ]),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: SafeArea(
            child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.black,
                labelColor: Theme.of(context).primaryColor,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: CustomTabIndicator(
                  color: Theme.of(context).primaryColor,
                  radius: 3,
                  fixedWidth: 16,
                ),
                tabs: const [
                  Tab(text: 'Request'),
                  Tab(text: 'Response'),
                  Tab(text: 'Error'),
                  Tab(text: 'TryAgain'),
                ]),
          ),
        ));
  }
}
