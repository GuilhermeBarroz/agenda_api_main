import 'dart:convert';
import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _userName =
      'Nome do Usuário'; // Nome do usuário (pode ser substituído pela lógica de login)

  File? _selectedProfileImage; // Imagem de perfil selecionada

  void _changeProfilePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedProfileImage = File(pickedImage.path);
      });
    }
  }

  void _updateUserName(String name) {
    setState(() {
      _userName = name;
    });
  }

  void _showNewAppointmentBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Novo Agendamento',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Escolha a data:'),
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: const Color(0xff2E4599),
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // Lógica para atualizar a data selecionada
                  },
                ),
                SizedBox(height: 16),
                Text('Horário de início:'),
                TimeInput(onTimeSelected: (startTime) {
                  // Lógica para atualizar o horário de início
                }),
                SizedBox(height: 16),
                Text('Horário de fim:'),
                TimeInput(onTimeSelected: (endTime) {
                  // Lógica para atualizar o horário de fim
                }),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _addAppointment();
                  },
                  child: Text('Confirmar'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff2E4599),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMyAppointmentsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Definir como true
      builder: (context) {
        return FractionallySizedBox(
          // Adicionar FractionallySizedBox
          heightFactor: 0.5, // Definir heightFactor como 0.5 (50% da tela)
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Meus Agendamentos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  // Aqui exibir lista de agendamento
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addAppointment() async {
    TimeOfDay startTime = TimeOfDay.now();
    TimeOfDay endTime = TimeOfDay.now();

    // Obter a data selecionada
    DateTime selectedDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    // Obter o horário de início selecionado
    String formattedStartTime = startTime.format(context);

    // Obter o horário de fim selecionado
    String formattedEndTime = endTime.format(context);

    // Criar o objeto de agendamento
    Map<String, dynamic> appointmentData = {
      'data': formattedDate,
      'hora_inicio': formattedStartTime,
      'hora_fim': formattedEndTime,
    };

    // Converter o objeto de agendamento em JSON
    String jsonData = jsonEncode(appointmentData);

    // Enviar a requisição para o backend
    try {
      final response = await http.post(
        Uri.parse('https://agenda-production-8c38.up.railway.app/agendamento'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // Agendamento realizado com sucesso
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Agendamento realizado'),
              content: Text('Agendamento realizado com sucesso'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Falha ao realizar o agendamento');
      }
    } catch (error) {
      // Erro ao enviar a requisição para o backend
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Não foi possível realizar o agendamento'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 70),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _changeProfilePicture,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xff2E4599),
                        child: _selectedProfileImage != null
                            ? ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: _selectedProfileImage!.path,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )
                            : const Icon(
                                Icons.account_circle,
                                size: 100,
                              ),
                      ),
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xff2E4599),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Olá, $_userName',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: const Color(0xff2E4599),
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // Lógica para atualizar a data selecionada
              },
            ),
            const SizedBox(height: 320),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _showNewAppointmentBottomSheet,
                  child: const Text('Novo Agendamento'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff2E4599),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _showMyAppointmentsBottomSheet,
                  child: const Text('Meus Agendamentos'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff2E4599),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color(0xff2E4599), // Cor de fundo
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Image.asset("assets/logoNassau.png"),
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}

class TimeInput extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;

  const TimeInput({required this.onTimeSelected});

  @override
  _TimeInputState createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _showTimePicker() async {
    final timePicker = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (timePicker != null) {
      setState(() {
        _selectedTime = timePicker;
        widget.onTimeSelected(_selectedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showTimePicker,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff2E4599),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              color: const Color(0xff2E4599),
            ),
            SizedBox(width: 8),
            Text(
              _selectedTime.format(context),
              style: TextStyle(
                color: const Color(0xff2E4599),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
