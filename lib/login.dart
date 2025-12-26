import 'package:flutter/material.dart';
import 'package:form_validation/mybutton.dart';
import 'package:form_validation/myinput.dart';
import 'package:provider/provider.dart';
import 'package:form_validation/auth.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCont=TextEditingController();
  TextEditingController passCont=TextEditingController();
  bool isLoading=false;
  

  var key=GlobalKey<FormState>();
  void _handleSubmit(String email,String password)async{
    setState(() {
      isLoading=true;
    });
    if(key.currentState!.validate()){
      await Provider.of<Auth>(context,listen: false).login(email,password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('login successfull')));
    }else{
      setState(() {
        isLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('login failed')));
    }

  }
  @override
  Widget build(BuildContext context) {
    final auth=context.watch<Auth>();
    return Scaffold(
      body:Container(
        child: Padding(
          
          child: Form(
            key: key,
            child: Column(
            children: [
              Center(
                child: Text('Login'),
              ),
              MyInput(
                
                icon: Icons.email_sharp,
                labelText: 'Email', validate:(value){
                  if(value!.isEmpty){
                    return 'Enter an email';
                  }
                  return null;
              }, 
              mycontroller: emailCont, 
              obsecureText: false),
              SizedBox(height: 10,),
              MyInput(
                
                icon: Icons.password_sharp, 
              labelText: 'Password', 
              validate: (value){
                if(value!.isEmpty){
                  return 'Enter a password';
                }
                return null;
              },
               mycontroller:passCont,
               
                obsecureText: true),
               SizedBox(height: 10,),
               if (auth.authError != null)
  Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      auth.authError!,
      style: const TextStyle(color: Colors.red),
    ),
  ),
               isLoading?CircularProgressIndicator():MyButton(text: 'login', 
               onPress:(){ 
                _handleSubmit(emailCont.text,passCont.text);
                }, 
               width: MediaQuery.of(context).size.width, height: 50)
            ],
          )),
          padding: EdgeInsets.only(top:50,left:20,right:20)),
      )
    );
  }
}