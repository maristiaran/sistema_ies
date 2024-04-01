import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/crud_roles/domain/crud_roles.dart';
import 'package:sistema_ies/crud_roles/presentation/administrative_dialog.dart';
import 'package:sistema_ies/crud_roles/presentation/teacher_dialog.dart';
import 'package:sistema_ies/core/domain/utils/prints.dart';
// import 'package:sistema_ies/crud_roles/presentation/adding_role_dialog.dart';

class CRUDRolesPage extends ConsumerWidget {
  const CRUDRolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Future<bool> showAlertDialog(BuildContext context) async {
    //   // set up the buttons
    //   Widget cancelButton = ElevatedButton(
    //     child: const Text("Cancel"),
    //     onPressed: () {},
    //   );
    //   Widget continueButton = ElevatedButton(
    //     child: const Text("Continue"),
    //     onPressed: () {},
    //   ); // set up the AlertDialog
    //   AlertDialog alert = AlertDialog(
    //     title: const Text("AlertDialog"),
    //     content: const Text(
    //         "Would you like to continue learning how to use Flutter alerts?"),
    //     actions: [
    //       cancelButton,
    //       continueButton,
    //     ],
    //   ); // show the dialog
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return alert;
    //     },
    //   );
    // }

    final crudStatesProvider = ref.watch(
        IESSystem().crudTeachersAndStudentsUseCase.stateNotifierProvider);
    // final SearchController _searchController = SearchController();
    if (crudStatesProvider.stateName == CRUDRoleStateName.initial) {
      crudStatesProvider as CRUDRoleInitialState;
      // print("crudstate ${crudStatesProvider.searchedUsers}");
      // Future<Student?> studentIfAny;
      return Scaffold(
        appBar: AppBar(
          // leading: null,
          automaticallyImplyLeading: false,
          title: const Text('Asignación de roles'),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    IESSystem().homeUseCase.onReturnFromOperation();
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  IESSystem().crudTeachersAndStudentsUseCase.cancel();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  prints('Guardar cambios');
                },
                child: const Text(
                  'Guardar cambios',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: Center(
            child: Align(
                alignment: const Alignment(0.00, -1.0),
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    width: MediaQuery.of(context).size.width / 0.5,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          SearchAnchor(
                              // searchController: _searchController,
                              builder: (BuildContext context,
                                  SearchController controller) {
                            return SearchBar(
                              controller: controller,
                              padding:
                                  const MaterialStatePropertyAll<EdgeInsets>(
                                      EdgeInsets.symmetric(horizontal: 16.0)),
                              // onTap: () {
                              //   controller.openView();
                              // },
                              onChanged: (val) {
                                if (val.endsWith(",")) {
                                  IESSystem()
                                      .crudTeachersAndStudentsUseCase
                                      .searchUser(
                                          userDescription:
                                              val.substring(0, val.length - 1));
                                }
                              },
                              trailing: <Widget>[
                                Tooltip(
                                  message: 'Buscar usuario',
                                  child: IconButton(
                                    isSelected: true,
                                    onPressed: () {},
                                    icon: const Icon(Icons.search),
                                  ),
                                )
                              ],
                            );
                          }, suggestionsBuilder: (BuildContext context,
                                  SearchController controller) {
                            return [];
                          }),
                          ListView.builder(
                            itemCount: crudStatesProvider.searchedUsers.length,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) => ListTile(
                                title: Text(crudStatesProvider
                                    .searchedUsers[index]
                                    .toString()),
                                onTap: (() => IESSystem()
                                    .crudTeachersAndStudentsUseCase
                                    .selectUser(
                                        user: crudStatesProvider
                                            .searchedUsers[index])))),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(crudStatesProvider.selectedUser == null
                                ? 'Nombre(s): '
                                : 'Nombre(s): ${crudStatesProvider.selectedUser!.firstname}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(crudStatesProvider.selectedUser == null
                                ? 'Apellido: '
                                : 'Apellido: ${crudStatesProvider.selectedUser!.surname}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(crudStatesProvider.selectedUser == null
                                ? 'DNI: '
                                : 'DNI: ${crudStatesProvider.selectedUser!.dni.toString()}'),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text('Roles'),
                              const Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    Administrative? newAdministrativeRolIfAny =
                                        await showDialog<Administrative?>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AddingAdministrativeDialog(
                                                newuserRoleIfAny: null,
                                              );
                                            });
                                    if (newAdministrativeRolIfAny != null) {
                                      IESSystem()
                                          .crudTeachersAndStudentsUseCase
                                          .addUserRole(
                                              userRole:
                                                  newAdministrativeRolIfAny);
                                    }
                                  },
                                  icon: Image.asset(
                                    'lib/core/assets/images/addAdministrative.png',
                                    width: 48,
                                    height: 48,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    Teacher? newTeacherRoleIfAny =
                                        await showDialog<Teacher?>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AddingTeacherDialog(
                                                newuserRoleIfAny: null,
                                              );
                                            });
                                    if (newTeacherRoleIfAny != null) {
                                      IESSystem()
                                          .crudTeachersAndStudentsUseCase
                                          .addUserRole(
                                              userRole: newTeacherRoleIfAny);
                                    }
                                  },
                                  icon: Image.asset(
                                    'lib/core/assets/images/addTeacher.png',
                                    width: 48,
                                    height: 48,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    Manager? newManagerRoleIfAny =
                                        await showDialog<Manager?>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AddingAdministrativeDialog(
                                                newuserRoleIfAny: null,
                                              );
                                            });
                                    if (newManagerRoleIfAny != null) {
                                      IESSystem()
                                          .crudTeachersAndStudentsUseCase
                                          .addUserRole(
                                              userRole: newManagerRoleIfAny);
                                    }
                                  },
                                  icon: Image.asset(
                                    'lib/core/assets/images/addSystemAdmin.png',
                                    width: 48,
                                    height: 48,
                                  )),
                            ],
                          ),
                          SizedBox(
                              height: 250,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    crudStatesProvider.selectedUser == null
                                        ? 0
                                        : crudStatesProvider
                                            .selectedUser!.roles.length,
                                itemBuilder: (context, index) => ListTile(
                                  title: Text(crudStatesProvider
                                      .selectedUser!.roles[index]
                                      .toString()),
                                  subtitle: Text(crudStatesProvider
                                      .selectedUser!.roles[index]
                                      .subtitle()),
                                  trailing: SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: Row(children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Estás seguro de querer eliminar al rol ${crudStatesProvider.selectedUser!.roles[index].toString()}"),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      child: const Text("OK"),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      child: const Text(
                                                          "Cancelar"),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, false);
                                                      },
                                                    )
                                                  ],
                                                );
                                              },
                                            ).then((result) {
                                              if (result) {
                                                IESSystem()
                                                    .crudTeachersAndStudentsUseCase
                                                    .removeUserRole(
                                                        userRole:
                                                            crudStatesProvider
                                                                .selectedUser!
                                                                .roles[index]);
                                              }
                                            });
                                          },
                                          icon: const Icon(Icons.delete))
                                    ]),
                                  ),
                                ),
                              )),
                        ])))),
      );
    } else {
      return Container();
    }
  }
}
