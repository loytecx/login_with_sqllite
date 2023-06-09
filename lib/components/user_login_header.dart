import 'package:flutter/material.dart';

class UserLoginHeader extends StatelessWidget {
  final String nameHeader;
  final String? avatar;
  const UserLoginHeader(this.nameHeader, this.avatar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          nameHeader,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 20),
        _newMethod(),
        const SizedBox(height: 20),
        const Text(
          'Aula de Dispositivos Móveis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  CircleAvatar _newMethod() {
    if (avatar!.isNotEmpty) {
      return CircleAvatar(
        maxRadius: 80,
        backgroundImage: NetworkImage(
          avatar!,
        ),
      );
    } else {
      return CircleAvatar(
        maxRadius: 80,
        child: Image.asset(
          'assets/images/login.png',
        ),
      );
    }
  }
}
