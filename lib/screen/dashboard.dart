import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:login_with_sqllite/common/messages/messages.dart';
import 'package:login_with_sqllite/common/routes/view_routes.dart';
import 'package:login_with_sqllite/external/database/db_sql_lite.dart';
import 'package:login_with_sqllite/model/user_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final List<UserModel> users;

  @override
  void didChangeDependencies() {
    users = ModalRoute.of(context)!.settings.arguments as List<UserModel>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 80.0),
              centerTitle: true,
              title: Text('Admin Dashboard'),
            ),

            //automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Center(
                  child: ExpansionTile(
                    title: Text(
                      "${users.elementAt(index).userId}: ${users.elementAt(index).userName}",
                    ),
                    subtitle: Text(
                      users.elementAt(index).userEmail,
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TextButton.icon(
                              onPressed: () async {
                                await Navigator.of(context).pushNamed(
                                  RoutesApp.loginUpdate,
                                  arguments: users.elementAt(index),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.amber.shade600,
                              ),
                              label: Text("Atualizar",
                                  style:
                                      TextStyle(color: Colors.amber.shade600))),
                          TextButton.icon(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  headerAnimationLoop: false,
                                  // animType: AnimType.topSlide,
                                  title: 'Confirma Exclusão???',
                                  btnCancelOnPress: () {},
                                  btnOkText: 'Sim',
                                  btnOkOnPress: () {
                                    final db = SqlLiteDb();
                                    db
                                        .deleteUser(
                                            users.elementAt(index).userId)
                                        .then(
                                      (value) {
                                        AwesomeDialog(
                                          context: context,
                                          headerAnimationLoop: false,
                                          dialogType: DialogType.success,
                                          title: MessagesApp.successUserDelete,
                                          btnOkOnPress: () =>
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  RoutesApp.home,
                                                  (Route<dynamic> route) =>
                                                      false),
                                          btnOkText: 'OK',
                                        ).show();
                                      },
                                    ).catchError((error) {
                                      AwesomeDialog(
                                        context: context,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.error,
                                        title: MessagesApp.errorDefault,
                                        btnCancelOnPress: () {},
                                        btnCancelText: 'OK',
                                      ).show();
                                    });
                                  },
                                  btnCancelText: 'Cancelar',
                                ).show();
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.pink,
                              ),
                              label: const Text("Excluir",
                                  style: TextStyle(color: Colors.pink))),
                        ],
                      )
                    ],
                  ),
                );
              },
              childCount: users.length,
            ),
          ),
        ],
      ),
    );
  }
}
