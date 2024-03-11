import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splashscreen2.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  

  @override
  State<Login> createState() => _LoginState();

  
}

class _LoginState extends State<Login> {

  void loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const splashtwo()),
    );
  }

  



  bool? ischecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width:400 ,
                height: 230,
                color: Colors.white,
                child: Lottie.asset('assets/animation_lk5rdc8w.json'),
              ),
        
              Padding(
                padding: const EdgeInsets.only(left: 30.17,top: 50),
                child: Container(
                  width: 162,
                  height: 50,
                  child: const Text("Log in \nyour account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1
                  ),),
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 22),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
                  width: 320,
                  height:45,
                  child: TextField(
                    
                    decoration: InputDecoration(
                      
                      border: OutlineInputBorder(borderSide: const BorderSide(width: 0.5,color: Colors.red,),borderRadius: BorderRadius.circular(7))
                    ),
                  ),
                ),
              ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 30,),
                   child: Container(
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
                               width: 320,
                               height:45,
                               child: TextField(
                    
                    decoration: InputDecoration(
                      
                      border: OutlineInputBorder(borderSide: const BorderSide(width: 0.5,color: Colors.red,),borderRadius: BorderRadius.circular(7))
                    ),
                               ),
                             ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Row(
                    
                    children: [
                      Checkbox(
                        
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        
                        value: ischecked, 
                        onChanged:(newBool){
                        setState(() {
                          ischecked =newBool;
                          
                        });
                      }),
        
                      const Text("Remember me",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff3D3E48)),),
                      const Spacer(),
                      const Text("Forgot password?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xff023B69)),)
        
                    ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 30,right: 30,top: 75),
                   child: InkWell(
                    onTap: loginUser,
                     child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: const Color(0xffFF8C23)
                      ),
                      width: 320,
                      height: 45,
                      child: const Center(child: Text("Login",style: TextStyle(
                        fontSize: 15,fontWeight: FontWeight.w700,
                        color: Color(0xffffffff)
                      ),)),
                                    
                     ),
                   ),
                 )
            ],
          ),
        ),
    
      ),
    );
  }
}