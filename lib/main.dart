import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

enum GenderList { male, female }

const List<String> list = <String>['Левая', 'Правая', 'Обе'];
GenderList? _gender = GenderList.male;
Cat cat = new Cat();

class ChangeGanderCatForm extends StatefulWidget {
  const ChangeGanderCatForm({super.key});

  @override
  State<StatefulWidget> createState() => ChangeGanderCatFormState();
}

class ChangeGanderCatFormState extends State {
  //GenderList? _gender = GenderList.male;

  void _changeGender(GenderList? value) {
    setState(() {
      _gender = value;
      if (value == GenderList.male) {
        cat.gender = "Кот";
      } else if(_gender == GenderList.female) {
        cat.gender = "Кошка";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 85.0, top: 10.0),
      child: Column(children: <Widget>[
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
      ]),
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
        padding: const EdgeInsets.only(left: 88.0),
        child: CheckboxListTile(
          value: isChecked,
          title: const Text(
              'Ознакомлены ли вы с первым правилом кошачьего клуба?'),
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ));
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<StatefulWidget> createState() => RegistrationFormState();
}

class RegistrationFormState extends State {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = list.first;

  void _resultButtonClick() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Добро пожаловать в клуб'),
        backgroundColor: Colors.green,
      ));
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return WidgetResult();
        },
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Padding(padding: EdgeInsets.only(top: 70.0)),
        Text(
          'Регистрация в кошачий клуб',
          style: TextStyle(fontSize: 20.0),
        )
      ]),
      Container(
          padding: const EdgeInsets.only(left: 70.0, top: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(children: [
                  Column(
                    children: [
                      Row(
                        children: const [
                          Text('Имя нового участника:',
                              style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 400,
                            padding:
                                const EdgeInsets.only(left: 105.0, top: 10.0),
                            child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Введите имя вашего кота',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  cat.name = text;
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста введите имя вашего кота';
                                  }
                                  return null;
                                }),
                          ),
                        ],
                      )
                    ],
                  )
                ]),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 105.0, top: 20.0),
                      child: const Text(
                        'Пол вашего рэмбо',
                        style: TextStyle(fontSize: 17.0),
                      ),
                    )
                  ],
                ),
                const ChangeGanderCatForm(),
                Row(children: [
                  Column(children: [
                    Container(
                        padding: const EdgeInsets.only(left: 105.0, top: 20.0),
                        child: const Text('Вес будущего чемпиона(кг):',
                            style: TextStyle(fontSize: 17.0))),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      width: 160,
                      height: 80,
                      child: NumberInputWithIncrementDecrement(
                        controller: TextEditingController(),
                        onIncrement: (num newlyIncrementedValue) {
                          cat.weight = newlyIncrementedValue;
                        },
                      ),
                    ),
                  ])
                ]),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                            padding:
                                const EdgeInsets.only(left: 105.0, top: 20.0),
                            child: const Text('Ударная лапа:',
                                style: TextStyle(fontSize: 17.0))),
                        Container(
                          padding: const EdgeInsets.only(left: 73.0, top: 10.0),
                          child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                  cat.mainPaw = value;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              padding:
                              const EdgeInsets.only(left: 32.0, top: 15.0),
                              child: const Text('Описание вашего любимца:',
                                  style: TextStyle(fontSize: 17.0))
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 400,
                            padding:
                                const EdgeInsets.only(left: 102.0, top: 15.0),
                            child: TextFormField(
                                maxLines: 20,
                                minLines: 5,
                                decoration: const InputDecoration(
                                  hintText: 'Введите описание вашего любимца',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  cat.description = text;
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста введите описание';
                                  }
                                  return null;
                                }),
                          ),
                        ],
                      )
                    ],
                  )
                ]),
                const CheckBoxForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: ElevatedButton(
                          onPressed: _resultButtonClick,
                          child: const Text('Завершить')),
                    ),
                  ],
                ),
              ],
            ),
          ))
    ]));
  }
}

class WidgetResult extends StatefulWidget {
  const WidgetResult({super.key});

  @override
  State<StatefulWidget> createState() => WidgetResultState();
}

class WidgetResultState extends State {
  String _genderState = "";
  void checkGenderState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результат регистрации'),
      ),
      body: Container(
            child: Column (
                children: [
                  Row(
                    children: [
                        Text("Имя участника: ${cat.name}"),
                    ]
                  ),
                  Row(
                      children: [
                        Text("Пол: ${cat.gender}"),
                      ]
                  ),
                  Row(
                      children: [
                        Text("Вес: ${cat.weight}"),
                      ]
                  ),
                  Row(
                      children: [
                        Text("Ударная лапа: ${cat.mainPaw}"),
                      ]
                  ),
                  Row(
                      children: [
                        Text("Описание: ${cat.description}"),
                      ]
                  ),
                ]
            )
        )
    );
  }
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Регистрация'),
          ),
          body: SingleChildScrollView(child: RegistrationForm())),
    ));

class Cat {
  String name = "";
  String gender = "Кот";
  num weight = 0;
  String mainPaw = "Левая";
  String description = "";
}