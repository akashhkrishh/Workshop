
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/create_screen.dart';
import 'package:todo_app/screens/todo_info_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String Roll = "";
  List todos = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    getAllTodos();
  }

  String url = "http://todo.oswinjerome.in/api/todos";



  void getAllTodos() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Roll = prefs.get("rollNo").toString();
    Dio().get(url, queryParameters: {
      "user_id": prefs.getString("rollNo"),
    }).then((value) {
      setState(() {
        todos = value.data;
        isLoading = false;
      });
    });
  }

  void createTodo(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    Dio().post(url, data: {
      "title": title,
      "user_id": prefs.getString("rollNo"),
      "completed": false,
    }).then((value) {
      getAllTodos();
      isLoading = false;
    });
  }

  void updateTodo(int id, bool value) {
    Dio().put(url + "/" + id.toString(), data: {
      "completed": value,
    }).then((value) {
      getAllTodos();
    });
  }

  void deleteTodo(int id) {
    Dio().delete(url + "/" + id.toString()).then((value) {
      getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todos"),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? title = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctz) => CreateScreen(),
            ),
          );

          if (title != null && title != "") {
            print("Creating todo");
            createTodo(title);
          }
        },
        child: Icon(
          Icons.add,
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(

                child: Image.asset("images/logo1.png"),
              ),
              Text(Roll,textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => TodoInfoScreen(
                          title: todos[index]['title'],
                        ),
                      ),
                    );
                  },
                  title: Text(todos[index]['title']),
                  subtitle: todos[index]['completed']
                      ? Text("Completed")
                      : Text("Not completed"),
                  leading: Checkbox(
                    value: todos[index]['completed'],
                    onChanged: (value) {
                      setState(() {
                        todos[index]['completed'] = !todos[index]['completed'];
                        updateTodo(todos[index]['id'], value!);
                      });
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      deleteTodo(todos[index]['id']);
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                );
              })),
    );
  }
}
