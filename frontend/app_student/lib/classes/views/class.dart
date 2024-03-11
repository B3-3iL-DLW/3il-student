import 'package:app_student/api/classes/entities/class.dart';
import 'package:app_student/classes/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:app_student/classes/bloc/class_bloc.dart';
import 'package:app_student/classes/widgets/header/header_logo.dart';
import 'package:app_student/classes/widgets/header/header_title.dart';
import 'package:app_student/classes/widgets/header/header_text.dart';

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
      body: Column(
        children: [
          HeaderLogo(),
          HeaderTitle("Bonjour, Yan"),
          HeaderText("Dans quelle classe êtes-vous ?"),
          Expanded(
            child: StreamBuilder<List<Class>>(
              stream: _classBloc.classStream,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Class>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return CustomCard(classesList: snapshot.data!);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _classBloc.dispose();
    super.dispose();
  }
}
