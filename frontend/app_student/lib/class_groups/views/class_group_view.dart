import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassListPage extends StatelessWidget {
  const ClassListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final classRepository =
        RepositoryProvider.of<ClassGroupRepository>(context);
    final classCubit = ClassGroupCubit(classRepository: classRepository);

    return BlocProvider<ClassGroupCubit>(
      create: (context) => classCubit..fetchClasses(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Class List'),
        ),
        body: BlocBuilder<ClassGroupCubit, ClassGroupState>(
          builder: (context, state) {
            if (state is ClassGroupLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ClassGroupLoaded) {
              return ListView.builder(
                itemCount: state.classes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.classes[index].name),
                    subtitle: Text(state.classes[index].file),
                  );
                },
              );
            } else if (state is ClassGroupError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
