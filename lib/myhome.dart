import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_validation/auth.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    final auth=context.watch<Auth>();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            IconButton(onPressed: ()async{
              await Provider.of<Auth>(context,listen: false).logout();

            }, icon: Icon(Icons.logout_outlined)),
            Text(auth.user!.email)
          ],
        )
      ),
    );
  }
}