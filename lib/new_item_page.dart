import 'package:flutter/material.dart';

class NewItemPage extends StatelessWidget {
  NewItemPage({super.key});
  List<TextEditingController> controllers = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 5; i++) {
      controllers.add(TextEditingController());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Malbob Market with Firebase'),
      ),
      bottomNavigationBar: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: controllers[0],
                decoration: const InputDecoration(
                    hintText: '너의 이름은?',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              ),
              TextFormField(
                controller: controllers[1],
                decoration: const InputDecoration(
                    hintText: '지역',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                controller: controllers[2],
                decoration: const InputDecoration(
                    hintText: '제목 쓰기',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                controller: controllers[3],
                decoration: const InputDecoration(
                    hintText: '내 물건 소개하기',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Map<String, String> item = {
                                'name': controllers[0].text,
                                'location': controllers[1].text,
                                'title': controllers[2].text,
                                'msg': controllers[3].text,
                              };
                              Navigator.pop(context, item);
                            },
                            child: const Text('Save!'))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
