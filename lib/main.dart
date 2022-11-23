import 'package:flutter/material.dart';

enum GenderList {
  male,
  female
}

class ChangeGanderCatForm extends StatefulWidget {
  const ChangeGanderCatForm({super.key});

  @override
  State<StatefulWidget> createState() => ChangeGanderCatFormState();
}

class ChangeGanderCatFormState extends State {
  GenderList? _gender = GenderList.male;
  void _changeGender (GenderList? value) {
    setState(() {
      _gender = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 85.0, top: 10.0),
      child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Кот'),
              leading: Radio<GenderList>(
                value: GenderList.male,
                groupValue: _gender,
                onChanged: _changeGender,
              ),
            ),
            ListTile(
              title: const Text('Кошка'),
              leading: Radio<GenderList>(
                value: GenderList.female,
                groupValue: _gender,
                onChanged: _changeGender,
              ),
            ),
          ]
      ),
    );
  }
}

class CheckBoxForm extends StatefulWidget {
  const CheckBoxForm({super.key});

  @override
  State<StatefulWidget> createState() => CheckBoxFormState();
}

class CheckBoxFormState extends State {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 90.0),
        child: CheckboxListTile(
          value: isChecked,
          title: const Text(
              'Ознакомлены ли вы с первым правилом кошачьего клуба?'
          ),
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        )
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<StatefulWidget> createState() => RegistrationFormState();
}

class RegistrationFormState extends State {
  final _formKey = GlobalKey<FormState>();
  //GenderList? _gender = GenderList.male;
  //bool isChecked = false;

  void _resultButtonClick() {
      if(_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Добро пожаловать в клуб'),
              backgroundColor: Colors.green,));
      }
  }

  /*void _changeGender (GenderList? value) {
    setState(() {
      _gender = value;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(padding: EdgeInsets.only(top: 70.0)),
                Text('Регистрация в кошачий клуб',
                  style: TextStyle(fontSize: 20.0),)
              ]
          ),
          Container(
              padding: const EdgeInsets.only(left: 70.0, top: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children:[
                        Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                    'Имя нового участника:',
                                    style: TextStyle(fontSize: 17.0)
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 400,
                                  padding: const EdgeInsets.only(left: 105.0, top: 10.0),
                                  child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Введите имя вашего кота',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Пожалуйста введите имя вашего кота';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ]
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 105.0,top: 20.0),
                          child: const Text('Пол вашего рэмбо',
                            style: TextStyle(fontSize: 17.0),),
                        )
                      ],
                    ),
                    const ChangeGanderCatForm(),
                    const CheckBoxForm(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 70.0),
                            child: ElevatedButton(
                                onPressed: _resultButtonClick,
                                child: const Text('Завершить')
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              )
          )
        ]
      )
    );
  }
}

void main() => runApp (
   MaterialApp (
     debugShowCheckedModeBanner: false,
     home: Scaffold(
       appBar: AppBar(title: const Text('Регистрация'),),
       body: RegistrationForm()
     ),
   )
);


