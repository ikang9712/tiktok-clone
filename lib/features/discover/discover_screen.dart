import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _textEditingController;
  late TabController _tabController;
  bool _isWriting = false;
  String _currentText = "";

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      _currentText = _textEditingController.text;
      print(_currentText);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 2,
          title: Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.angleLeft,
                size: Sizes.size24,
              ),
              Gaps.h20,
              Expanded(
                child: SizedBox(
                  height: Sizes.size48,
                  child: TextField(
                    controller: _textEditingController,
                    onTap: _onStartWriting,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size14,
                          ),
                          child: Row(
                            mainAxisSize: _isWriting
                                ? MainAxisSize.min
                                : MainAxisSize.max,
                            children: [
                              if (!_isWriting)
                                FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: Colors.grey.shade800,
                                  size: Sizes.size16 + 2,
                                ),
                              if (_isWriting)
                                GestureDetector(
                                  onTap: _stopWriting,
                                  child: FaIcon(
                                    FontAwesomeIcons.solidCircleXmark,
                                    color: Colors.grey.shade600,
                                    size: Sizes.size16 + 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              Sizes.size12,
                            ),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size10,
                          vertical: Sizes.size12,
                        )),
                  ),
                ),
              ),
              Gaps.h20,
              const FaIcon(
                FontAwesomeIcons.sliders,
                size: Sizes.size24,
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) {
              FocusManager.instance.primaryFocus?.unfocus();
              _isWriting = false;
            },
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                )
            ],
          ),
        ),
        body: TabBarView(children: [
          GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 21,
              ),
              itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: "assets/images/placeholder.png",
                              image:
                                  "https://images.unsplash.com/photo-1679108317142-aff8b4bd5ba1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1856&q=80"),
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "This is a very long caption for my tiktok that im uploading just now currently.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v8,
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                  "https://avatars.githubusercontent.com/u/85728616?v=4"),
                            ),
                            Gaps.h4,
                            const Expanded(
                              child: Text(
                                "Inhoooo Very Long name",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size14,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            const Text("2.5M")
                          ],
                        ),
                      )
                    ],
                  )),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(fontSize: 28),
              ),
            )
        ]),
      ),
    );
  }
}
