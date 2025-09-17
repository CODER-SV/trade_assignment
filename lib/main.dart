import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orders App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _horizontalScrollController = ScrollController();
  ScrollController _verticalScrollController = ScrollController();
  String selectedTrade = "SIGNORIA";
  String selectedMenu = "ORDERS";
  bool isPortfolioExpanded = false;
  bool isFundsExpanded = false;

  final Map<String, String> tradeValues = {
    "SIGNORIA": "0.00",
    "NIFTY BANK": "52,323.30",
    "NIFTY FIN SERVICE": "25,255.70",
    "RELCHEMQ": "162.73",
  };

  final List<String> menuItems = [
    "ORDERS",
    "MARKETWATCH",
    "EXCHANGE FILES",
    "PORTFOLIO",
    "FUNDS",
  ];

  final List<String> portfolioSub = [
    "Portfolio A",
    "Portfolio B",
    "Portfolio C",
  ];
  final List<String> fundsSub = ["Funds A", "Funds B", "Funds C"];

  final GlobalKey _menuKey = GlobalKey();
  List<String> get trades => tradeValues.keys.toList();

  Widget _buildCell(dynamic content, {List<IconData>? icons}) {
    Widget child;
    if (content is String) {
      child = Text(
        content,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.normal),
      );
    } else if (content is Widget) {
      child = content;
    } else {
      child = const SizedBox();
    }

    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          child,
          if (icons != null)
            ...icons.map((icon) => Icon(icon, size: 16, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildRow(List<dynamic> cells) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(children: cells.map((cell) => _buildCell(cell)).toList()),
    );
  }

  void showCustomMenu() {
    final RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: buildMenuItems(),
    );
  }

  List<PopupMenuEntry<String>> buildMenuItems() {
    List<PopupMenuEntry<String>> items = [];
    for (var menu in menuItems) {
      if (menu == "PORTFOLIO") {
        items.add(
          PopupMenuItem<String>(
            value: "PORTFOLIO",
            child: StatefulBuilder(
              builder: (context, setStateSB) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setStateSB(() {
                          isPortfolioExpanded = !isPortfolioExpanded;
                          isFundsExpanded = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(menu),
                          Icon(
                            isPortfolioExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                          ),
                        ],
                      ),
                    ),
                    if (isPortfolioExpanded)
                      ...portfolioSub.map(
                        (sub) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedMenu = sub;
                              isPortfolioExpanded = false;
                              isFundsExpanded = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(sub),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      } else if (menu == "FUNDS") {
        items.add(
          PopupMenuItem<String>(
            value: "FUNDS",
            child: StatefulBuilder(
              builder: (context, setStateSB) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setStateSB(() {
                          isFundsExpanded = !isFundsExpanded;
                          isPortfolioExpanded = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(menu),
                          Icon(
                            isFundsExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                          ),
                        ],
                      ),
                    ),
                    if (isFundsExpanded)
                      ...fundsSub.map(
                        (sub) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedMenu = sub;
                              isFundsExpanded = false;
                              isPortfolioExpanded = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(sub),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      } else {
        items.add(
          PopupMenuItem<String>(
            value: menu,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedMenu = menu;
                  isPortfolioExpanded = false;
                  isFundsExpanded = false;
                });
                Navigator.pop(context);
              },
              child: Text(menu),
            ),
          ),
        );
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Row(
          children: [
            Flexible(
              flex: 1,
              child: Image.asset(
                'assets/images/021_trade_logo.jpeg',
                width:
                    (screenWidth < screenHeight ? screenWidth : screenHeight) *
                    0.12,
                height:
                    (screenWidth < screenHeight ? screenWidth : screenHeight) *
                    0.06,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width:
                  (screenWidth < screenHeight ? screenWidth : screenHeight) *
                  0.02,
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PopupMenuButton<String>(
                    onSelected: (value) =>
                        setState(() => selectedTrade = value),
                    itemBuilder: (context) => trades.map((trade) {
                      return PopupMenuItem(
                        value: trade,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                trade,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize:
                                      (screenWidth < screenHeight
                                          ? screenWidth
                                          : screenHeight) *
                                      0.025,
                                ),
                              ),
                            ),
                            Text(
                              tradeValues[trade]!,
                              style: GoogleFonts.inter(
                                fontSize:
                                    (screenWidth < screenHeight
                                        ? screenWidth
                                        : screenHeight) *
                                    0.022,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            selectedTrade,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize:
                                  (screenWidth < screenHeight
                                      ? screenWidth
                                      : screenHeight) *
                                  0.025,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:
                        (screenWidth < screenHeight
                            ? screenWidth
                            : screenHeight) *
                        0.003,
                  ),
                  Text(
                    tradeValues[selectedTrade]!,
                    style: GoogleFonts.inter(
                      fontSize:
                          (screenWidth < screenHeight
                              ? screenWidth
                              : screenHeight) *
                          0.022,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Flexible(
            flex: 2,
            child: GestureDetector(
              key: _menuKey,
              onTap: () => showCustomMenu(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      selectedMenu,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            (screenWidth < screenHeight
                                ? screenWidth
                                : screenHeight) *
                            0.025,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width:
                (screenWidth < screenHeight ? screenWidth : screenHeight) *
                0.03,
          ),
          CircleAvatar(
            radius:
                (screenWidth < screenHeight ? screenWidth : screenHeight) *
                0.045,
            backgroundColor: const Color(0xffE4E4E7),
            child: Text(
              "LK",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize:
                    (screenWidth < screenHeight ? screenWidth : screenHeight) *
                    0.03,
              ),
            ),
          ),
          SizedBox(
            width:
                (screenWidth < screenHeight ? screenWidth : screenHeight) *
                0.02,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Open Orders",
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.025,
                    vertical: screenWidth * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.015),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.download,
                        color: Colors.black,
                        size: screenWidth * 0.025,
                      ),
                      SizedBox(width: screenWidth * 0.015),
                      Text(
                        'Download',
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                            ),
                                          ),
                                          child: const TextField(
                                            decoration: InputDecoration(
                                              hintText: "Enter text",
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.person_add_alt,
                                            color: Colors.black,
                                          ),
                                          onPressed: () =>
                                              print("Icon clicked!"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        "Lalit",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.search_outlined,
                                            color: Colors.black,
                                          ),
                                          onPressed: () =>
                                              print("Search clicked"),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
                                          ),
                                          child: const TextField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Search for stocks, future, option or index",
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 6,
                                  children: [
                                    _buildTag("RELIANCE"),
                                    _buildTag("TATAINVEST"),
                                    _buildTag("ASIANPAINTS"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: () => print("Stop clicked"),
                              icon: const Icon(
                                Icons.not_interested_outlined,
                                color: Colors.white,
                              ),
                              iconSize: 20,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  _buildCell(
                                    "Time",
                                    icons: [
                                      Icons.swap_vert,
                                      Icons.filter_alt_outlined,
                                    ],
                                  ),
                                  _buildCell(
                                    "Client",
                                    icons: [Icons.swap_vert],
                                  ),
                                  _buildCell("Ticker"),
                                  _buildCell(
                                    "Side",
                                    icons: [Icons.filter_alt_outlined],
                                  ),
                                  _buildCell(
                                    "Product",
                                    icons: [
                                      Icons.swap_vert,
                                      Icons.filter_alt_outlined,
                                    ],
                                  ),
                                  _buildCell(
                                    "Qty (Executed/Total)",
                                    icons: [Icons.swap_vert],
                                  ),
                                  _buildCell("Price", icons: [Icons.swap_vert]),
                                  _buildCell("Actions"),
                                ],
                              ),
                            ),
                            _buildRow([
                              "08:14:31",
                              "AAA001",
                              Row(
                                children: [
                                  Text('RELIANCE'),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.sensors_outlined,
                                    size: 16,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ],
                              ),
                              "Buy",
                              "CNC",
                              "50/100",
                              "250.50",
                              "⋯",
                            ]),
                            _buildRow([
                              "08:14:31",
                              "AAA003",
                              "MRF",
                              "Buy",
                              "NRML",
                              "10/20",
                              "2700.00",
                              "⋯",
                            ]),
                            _buildRow([
                              "08:14:31",
                              "AAA002",
                              Row(
                                children: [
                                  Text('ASIANPAINTS'),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.sensors_outlined,
                                    size: 16,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ],
                              ),
                              "Buy",
                              "NRML",
                              "10/30",
                              "1500.60",
                              "⋯",
                            ]),
                            _buildRow([
                              "08:14:31",
                              "AAA002",
                              "TATAINVEST",
                              "Sell",
                              "INTRADAY",
                              "10/10",
                              "2300.10",
                              "⋯",
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildPageButton('Previous'),
                          const SizedBox(width: 8),
                          const Text('1'),
                          const SizedBox(width: 8),
                          _buildPageButton('Next'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.close, size: 18, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildPageButton(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(text),
    );
  }
}
