import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool complate_button = false;
  bool check_form = false;
  bool go_check = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("ビルド");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: GestureDetector(
            onTap: () => primaryFocus?.unfocus(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "1文字以上のテキストを入力",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "申請",
                        style:
                            TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                      ),
                      Text(
                        "認証",
                        style:
                            TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                      ),
                      Text(
                        "完了",
                        style:
                            TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        height: 1,
                        color: Colors.black12,
                      ),
                    ),
                    AnimatedAlign(
                      alignment: go_check
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.slowMiddle,
                      onEnd: () {
                        if (go_check && check_form) {
                          complate_button = true;
                        } else {
                          setState(() {});
                        }
                      },
                      child: !go_check
                          ? null
                          : Icon(
                              Icons.add_task_outlined,
                              color: Colors.green.shade300,
                              size: 50,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: complate_button && check_form && go_check
            ? Colors.orange
            : Colors.lightGreen,
        onPressed: complate_button && check_form && go_check
            ? () {
                complate_button = false;
                check_form = false;
                go_check = false;
                _controller.clear();
                setState(() {});
              }
            : () async {
                go_check = true;
                setState(() {});
                await Future.delayed(const Duration(milliseconds: 750));
                if (_controller.text.isNotEmpty) {
                  await Future.delayed(const Duration(milliseconds: 750));
                  check_form = true;
                  accept_dialog(context);
                } else {
                  go_check = false;
                  error_dialog(context);
                }
                setState(() {});
              },
        tooltip: 'Increment',
        child: complate_button && check_form && go_check
            ? const Icon(Icons.replay)
            : const Icon(Icons.check),
      ),
    );
  }

  Future<Object?> error_dialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "認証失敗",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "もう一度やり直してください。",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Object?> accept_dialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(1),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "入力した文字",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _controller.text,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Text(
                "認証完了",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Icon(
                  Icons.done,
                  color: Colors.lightGreen,
                  size: 50,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
