import 'package:appcedid/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  int selectedRadio = 0; // Variable para el valor seleccionado del radio button

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor:Color.fromARGB(255, 235, 250, 151),
        title: Text('Registrarse',style: TextStyle(color: Colors.black)),
      ),
      body: Material(
      color: Color.fromARGB(255, 174, 243, 242),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/Icon_login_fondo.jpg",width:280,),
            
            

            // Radio Buttons
                      // Radio Buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      activeColor: Colors.yellow,
                      onChanged: (val) {
                        setSelectedRadio(1);
                      },
                    ),
                    Text("Soy Profesor"),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      activeColor: Colors.yellow,
                      onChanged: (val) {
                        setSelectedRadio(2);
                      },
                    ),
                    Text("Soy Asesor"),
                  ],
                ),
              ],
            ),
            

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


            SizedBox(height: 10),
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
                  hintText: "Nombre",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black.withOpacity(0.5),
                    ),
                ),
                cursorColor: Colors.black,
              ),
            ),
            ),


            SizedBox(height: 10),
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
            
            SizedBox(height: 10),

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
                  hintText: "Confirma la Contraseña",
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
            
            SizedBox(height: 10),
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
                child: Text("Crear Cuenta",
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


             SizedBox(height: 30),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                "Ya tengo una cuenta.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
               child: Text(
                "Iniciar Sesion.",
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
