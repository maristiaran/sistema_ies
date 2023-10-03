import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/crud_roles/domain/crud_roles.dart';
// import 'package:sistema_ies/core/domain/ies_system.dart';

class CRUDRolesPage extends ConsumerWidget {
  const CRUDRolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crudStatesProvider = ref.watch(
        IESSystem().crudTeachersAndStudentsUseCase.stateNotifierProvider);
    // final SearchController _searchController = SearchController();
    if (crudStatesProvider.stateName == CRUDRoleStateName.initial) {
      crudStatesProvider as CRUDRoleInitialState;
      print("crudstate ${crudStatesProvider.searchedUsers}");
      return Scaffold(
          appBar: AppBar(
            title: const Text('Asignación de roles'),
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
                              // onChanged: (val) {

                              //   print("onChanged: $val");
                              //   controller.openView();
                              // },
                              // leading: const Icon(Icons.search),
                              trailing: <Widget>[
                                Tooltip(
                                  message: 'Buscar usuario',
                                  child: IconButton(
                                    isSelected: true,
                                    onPressed: () {},
                                    icon: const Icon(Icons.search),
                                    // selectedIcon:
                                    //     const Icon(Icons.brightness_2_outlined),
                                  ),
                                )
                              ],
                            );
                          }, suggestionsBuilder: (BuildContext context,
                                  SearchController controller) {
                            return crudStatesProvider.searchedUsers
                                .map((e) => ListTile(
                                      title:
                                          Text("${e.surname} , ${e.firstname}"),
                                      onTap: () {
                                        IESSystem()
                                            .crudTeachersAndStudentsUseCase
                                            .selectUser(user: e);
                                        controller.closeView(
                                            "${e.surname} , ${e.firstname}");
                                        // });
                                      },
                                    ))
                                .toList();
                          }),
                          const SizedBox(height: 50),
                          Column(
                              // alignment: WrapAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // runSpacing: 15,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 200, minWidth: 100),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6.5,
                                        height: 40,
                                        // color: Theme.of(context)
                                        //     .colorScheme
                                        //     .tertiary,
                                        child: Text(crudStatesProvider
                                                    .selectedUser ==
                                                null
                                            ? 'Nombre(s): '
                                            : 'Nombre(s): ${crudStatesProvider.selectedUser!.firstname}'),
                                      ),
                                      Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 200, minWidth: 100),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6.5,
                                        height: 40,
                                        // color: Theme.of(context)
                                        //     .colorScheme
                                        //     .tertiary,
                                        child: Text(crudStatesProvider
                                                    .selectedUser ==
                                                null
                                            ? 'Apellido: '
                                            : 'Apellido: ${crudStatesProvider.selectedUser!.surname}'),
                                      ),
                                    ]),
                                Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 400, minWidth: 100),
                                  width:
                                      MediaQuery.of(context).size.width / 3.0,
                                  height: 40,
                                  // color: Theme.of(context).colorScheme.tertiary,
                                  child: Text(crudStatesProvider.selectedUser ==
                                          null
                                      ? 'DNI: '
                                      : 'DNI: ${crudStatesProvider.selectedUser!.dni.toString()}'),
                                ),
                                Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 400, minWidth: 100),
                                  width:
                                      MediaQuery.of(context).size.width / 3.0,
                                  height: 40,
                                  // color: Theme.of(context).colorScheme.tertiary,
                                  child: Text(crudStatesProvider.selectedUser ==
                                          null
                                      ? 'Email: '
                                      : 'Email: ${crudStatesProvider.selectedUser!.email}'),
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                    height: 50,
                                    width: 400,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: IESSystem()
                                          .homeUseCase
                                          .currentIESUser
                                          .roles
                                          .length,
                                      itemBuilder: (context, index) => ListTile(
                                        title: Text(IESSystem()
                                            .homeUseCase
                                            .currentIESUser
                                            .roles[index]
                                            .toString()),
                                        subtitle: Text(IESSystem()
                                            .homeUseCase
                                            .currentIESUser
                                            .roles
                                            .length
                                            .toString()),
                                      ),
                                    )),
                              ])
                        ]))),
          ));
    } else {
      return Container();
    }
  }
}
