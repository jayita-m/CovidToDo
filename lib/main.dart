import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 't o   d o   l i s t',
        home: new TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  //for the plus button
  void _addTodoItem(String task) {

    if(task.length > 0) {
      setState(() => _todoItems.add(task)); //makes sure the entry is non null
    }
  }

  // makes the list
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  // 1 to-do item
  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
        title: new Text(todoText),
        onTap: () => _promptRemoveTodoItem(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('t o   d o   l i s t')
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen, // will open a new screen
          tooltip: 'a d d   t a s k',
          child: new Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    //pushes this page
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context);
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter the task...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }




}
