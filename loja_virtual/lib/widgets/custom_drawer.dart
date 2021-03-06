import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);


  @override
  Widget build(BuildContext context) {
    Widget _buildDrawBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 20, 20, 20),
            Color.fromARGB(200, 30, 30, 30)
          ], begin: Alignment.topCenter, end: Alignment.bottomLeft)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 0, 15, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        "Flutter's\nClothing",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          print(model.isLoggedIn());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Olá, ${!model.isLoggedIn() ? '' : model.userData['name']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  'Entre ou cadastre-se >' : 'Sair',
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  if (!model.isLoggedIn())
                                    //Botão pra ir para tela de logar e cadastrar
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => LoginScreen())
                                  );
                                  else
                                    model.signOut();

                                },
                              )
                            ],
                          );
                        },

                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, 'Inicio', pageController, 0),
              DrawerTile(Icons.list, 'Produtos', pageController, 1),
              DrawerTile(Icons.location_on, 'Lojas', pageController, 2),
              DrawerTile(Icons.playlist_add_check, 'Meus Pedidos', pageController, 3)
            ],
          )
        ],
      ),
    );
  }
}
