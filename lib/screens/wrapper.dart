import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_shop/models/user.dart';
import 'package:stop_shop/screens/authentication/authenticate.dart';

import 'home.dart/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUid?>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
