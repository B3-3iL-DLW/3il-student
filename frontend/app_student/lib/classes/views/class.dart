import 'package:app_student/api/classes/entities/class.dart';
import 'package:flutter/material.dart';
import 'package:app_student/classes/bloc/class_bloc.dart';

class ClassListPage extends StatefulWidget {
  final ClassBloc classBloc;

  const ClassListPage({required this.classBloc, super.key});

  @override
  ClassListPageState createState() => ClassListPageState();
}

class ClassListPageState extends State<ClassListPage> {
  late ClassBloc _classBloc;

  @override
  void initState() {
    super.initState();
    _classBloc = widget.classBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class List'),
      ),
      body: StreamBuilder<List<Class>>(
        stream: _classBloc.classStream,
        builder: (BuildContext context, AsyncSnapshot<List<Class>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].file),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _classBloc.dispose();
    super.dispose();
  }
}
