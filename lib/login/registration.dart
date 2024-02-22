import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ecomerce/constrants.dart';
import 'package:ecomerce/login/login.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? name, phone, address, username, password;
  bool processing = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
 //webservice
 registration(String name,phone,address,username,password) async{
  print('webservice');
  print(username);
  print(password);
  var result;
  final Map<String, dynamic> Data = {
    'name':name,
    'phone':phone,
    'address':address,
    'username':username,
    'password':password,

  };
  final response = await http.post(
    
    Uri.parse("http://bootcamp.cyralearnings.com/registration.php"),
    body: Data,
  );
  print(response.statusCode);
   if (response.statusCode == 200){
    if(response.body.contains("success")){
      log("registration successfully completed");
      Navigator.push(context,MaterialPageRoute(builder: (context){
        return const LoginScreen();

      }
      ));
    }else{
      log("registration failed");

    }
   }else{
    result ={log (json.decode(response.body)['error'].toString())};
   }
   return result;
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Register Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Complete your details \n",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 15),
                          decoration:
                              const InputDecoration.collapsed(hintText: "Name"),
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter name";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration.collapsed(
                              hintText: "Phone"),
                          onChanged: (value) {
                            setState(() {
                              phone = value;
                            });
                          },
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your phone';
                            } else if (value.length > 10 || value.length < 10) {
                              return 'Please enter vlid phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 18),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 15),
                          maxLines: 4,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Address"),
                          onChanged: (value) {
                            setState(() {
                              address = value;
                            });
                          },
                          validator: (value) {
                             if (value == null || value.isEmpty) {
                              return 'Enter your address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration.collapsed(
                              hintText: "Username"),
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          validator: (value) {
                             if (value == null || value.isEmpty) {
                              return 'Enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration.collapsed(
                              hintText: "Password"),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (value) {
                             if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // ignore: deprecated_member_use
                            primary: Colors.white,
                            backgroundColor: maincolor),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            log("name==========" + name.toString());
                            log("phone==========" + phone.toString());
                            log("address==========" + address.toString());

                            log("username==========" + username.toString());
                            log("password==========" + password.toString());
                            registration(
                                name!, phone, address, username, password);
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do you have an account? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16,
                              color: maincolor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
