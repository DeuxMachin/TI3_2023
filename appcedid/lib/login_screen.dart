import 'package:appcedid/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false; // Variable para controlar el estado del botón "Recuérdame"

  Widget build(BuildContext context){
        return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        title: Text('Ingresar a Cuenta',style: TextStyle(color: Colors.black)),
      ),
      body: Material(
      color: Color.fromARGB(255, 174, 243, 242),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/Icon_login_fondo.jpg"),
            Container(
              padding: EdgeInsets.symmetric(horizontal:10),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 174, 243, 242).withOpacity(0.6),
                borderRadius: BorderRadius.circular(10)
              ) ,
              child: Center(

              child:TextFormField(
                decoration: InputDecoration(
                  hintText: "Correo Electronico",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black.withOpacity(0.5),
                    ),
                ),
                cursorColor: Colors.black,
              ),
            ),
            ),


            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal:10),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 174, 243, 242).withOpacity(0.6),
                borderRadius: BorderRadius.circular(10)
              ) ,
              child: Center(
              child:TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Contraseña",
                  prefixIcon: Icon(
                    Icons.lock, 
                  color:Colors.black.withOpacity(0.5)
                  ),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined,
                  color: Colors.black.withOpacity(0.5),
                  ),
                ),
                cursorColor: Colors.black,
              ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (newValue) {
                      setState(() {
                        rememberMe = newValue!;
                      });
                    },
                  ),
                  Text(
                    "Recuérdame",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                "¿Haz olvidado tu contraseña?",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
                         ],),
            
            SizedBox(height: 20),
             InkWell(
               child: Container(
                padding: EdgeInsets.symmetric(horizontal:10),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 250, 151),
                  borderRadius: BorderRadius.circular(10)
                ) ,
                child: Center(
                child: Text("Iniciar Sesion",
                style: TextStyle(
                  fontSize: 25, 
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2,
                  color: Colors.black54
                  ),
                 ),
                ),
                         ),
             ),


             SizedBox(height: 10),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                "No tienes una cuenta?",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                     ));
                },
               child: Text(
                "Crear Cuenta",
                style: TextStyle(
                  color: Color(0xFFF9A826),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
               )),
             ],
             ),
          ],
        ),
      ),
    ));
  }
}

