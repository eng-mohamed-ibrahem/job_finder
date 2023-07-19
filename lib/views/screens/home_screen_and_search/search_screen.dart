import 'package:flutter/material.dart';
import '../../widgets/home_and_search_screen_widgets/recent_suggest_search_jobs_widget.dart';
import '../../widgets/home_and_search_screen_widgets/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const SearchWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 36,
                width: double.infinity,
                color: const Color.fromRGBO(244, 244, 245, 1),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Recent Search',
                    style: TextStyle(
                      color: Color.fromRGBO(107, 114, 128, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return RecentSuggestWidget(
                      jobTitle: 'Twitter',
                      isRecent: true,
                      index: index,
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 36,
                width: double.infinity,
                color: const Color.fromRGBO(244, 244, 245, 1),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Popular searches',
                    style: TextStyle(
                      color: Color.fromRGBO(107, 114, 128, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return RecentSuggestWidget(
                      jobTitle: 'Twitter',
                      isRecent: false,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
