import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/todo_provider.dart';
import 'package:todoapp/views/add_todo.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Provider.of<TodoProvider>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addDataWidget(context),
      ),
      appBar: AppBar(
        title: Text('TODO List'),
        centerTitle: true,
      ),
      body: Container(
        child: Consumer<TodoProvider>(
          builder: (context, model, _) => FutureBuilder(
            future: model.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.data == null &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: model.todoData!.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      onTap: () {
                        print(model.todoData![index]["_id"]);
                        updateDataWidget(
                            context, model.todoData![index]["_id"]);
                      },
                      title: Text(model.todoData![index]["title"]),
                      subtitle: Text(model.todoData![index]["description"]),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print(model.todoData![index]["_id"]);
                          model.deleteData(
                              context, model.todoData![index]["_id"]);
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
