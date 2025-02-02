import 'package:flutter/material.dart';
import 'package:nesttask/config/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utils/date_formation.dart';
import '../../widgets/custom_card_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final dateFormation = DateFormation();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      // appBar: customAppbar(
      //     context: context,
      //     isLeading: const SizedBox.shrink(),
      //     title: "Search"),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: textController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Search Here....",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                          color: Color(0xff3366CC), width: 2.00))),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: Supabase.instance.client
                            .from("notes")
                            .stream(primaryKey: ['id']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100,
                                    child: ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      title: Container(
                                        width: 89,
                                        height: 10,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        width: 89,
                                        height: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            var snap = snapshot.data!;
                            return ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: snap.length,
                                itemBuilder: (context, index) {
                                  final data = snap[index];
                                  final startDate = dateFormation
                                      .listTileDate(data["start_date"]);
                                  final endDate = dateFormation
                                      .listTileDate(data["end_date"]);
                                  String name = data["title"];

                                  if (textController.text.isEmpty) {
                                    return Container();
                                  } else if (name
                                      .toLowerCase()
                                      .contains(textController.text)) {
                                    return Card(
                                      elevation: 1,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: InkWell(
                                          onTap: () {},
                                          child: CustomCardWidget(
                                            title: data["title"],
                                            date: '$startDate - $endDate',
                                            icon: Icons.calendar_today,
                                            context: context,
                                            taskId: data["id"],
                                            data: data,
                                          )),
                                    );
                                  } else {
                                    return Container();
                                  }
                                });
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
