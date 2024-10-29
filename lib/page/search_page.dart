import 'package:chatapp/widgets/friend_tag.dart';
import 'package:flutter/material.dart';

import '../network/app_api.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<SearchWidget> {
  final SearchController ctl = SearchController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
          color: Color.fromARGB(100, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: SearchAnchor(
        viewBackgroundColor: Colors.white,
            searchController: ctl,
            builder: (BuildContext c, SearchController ctl) {
              return IconButton(
                onPressed: () {
                  ctl.openView();
                },
                icon: const Icon(Icons.search_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              );
            },
            suggestionsBuilder:
                (BuildContext c, SearchController ctl) async {
              var user = await Api().searchUser(ctl.text);
              return List<FriendTag>.generate(1, (int index) {
                return FriendTag(
                  user: user,
                  statusFriendship: 'not',
                );
              });
            }
      ),
    );
  }
}
