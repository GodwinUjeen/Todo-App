import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/todo_provider.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();

addDataWidget(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 400.0,
            width: 400.0,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Add Title',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Add Description',
                  ),
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      Provider.of<TodoProvider>(context, listen: false).addData(
                          {
                            "title": titleController.text,
                            "description": descriptionController.text
                          },
                          context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      });
}

updateDataWidget(BuildContext context, String id) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 400.0,
            width: 400.0,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Update Title',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Update Description',
                  ),
                ),
                ElevatedButton(
                  child: Text('Update Data'),
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      Provider.of<TodoProvider>(context, listen: false)
                          .updateData({
                        "id": id,
                        "title": titleController.text,
                        "description": descriptionController.text
                      }, context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      });
}
