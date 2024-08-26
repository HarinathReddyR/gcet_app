import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gcet_app/db/user_dao.dart';
import 'package:http/http.dart' as http;

class EventRegUsers extends StatefulWidget {
  final int eventId;
  const EventRegUsers({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  State<EventRegUsers> createState() => _EventRegUsersState();
}

class _EventRegUsersState extends State<EventRegUsers> {
  List<dynamic> registeredUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchRegisteredUsers();
  }

  Future<void> _fetchRegisteredUsers() async {
    String token = await UserDao().getPersistToken(0);
    final response = await http.get(
      Uri.parse(
          'http://localhost:3000/api/events/${widget.eventId}/registrations'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        registeredUsers = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load registered users');
      Navigator.pop(context);
    }
  }

  Future<List<dynamic>> _fetchUserResponses(String username) async {
    String token = await UserDao().getPersistToken(0);
    final response = await http.get(
      Uri.parse(
          'http://localhost:3000/api/events/${widget.eventId}/responses/$username'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Handle error
      print('Failed to load user responses');
      return [];
    }
  }

  void _showUserResponsesDialog(BuildContext context, String username) async {
    List<dynamic> responses = await _fetchUserResponses(username);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$username\'s Responses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: responses.length,
                  itemBuilder: (context, index) {
                    final response = responses[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q${response['question_number']}: ${response['question']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          _buildResponseWidget(response),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponseWidget(Map<String, dynamic> response) {
    String questionType = response['question_type'];
    List<String> userResponses = response['user_response'] != null
        ? List<String>.from(response['user_response'])
        : [];
    List<String> options = response['options'] != null
        ? List<String>.from(response['options'])
        : [];

    switch (questionType) {
      case 'Radio':
        return Column(
          children: options.map((option) {
            return RadioListTile<String>(
              value: option,
              groupValue: userResponses.isNotEmpty ? userResponses.first : null,
              onChanged: null,
              title: Text(option),
            );
          }).toList(),
        );
      case 'Checkbox':
        return Column(
          children: options.map((option) {
            return CheckboxListTile(
              value: userResponses.contains(option),
              onChanged: null,
              title: Text(option),
            );
          }).toList(),
        );
      case 'Dropdown':
        return DropdownButton<String>(
          value: userResponses.isNotEmpty ? userResponses.first : null,
          isExpanded: true,
          items: options.map<DropdownMenuItem<String>>((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: null,
        );
      case 'Text':
      default:
        return Text(userResponses.isNotEmpty ? userResponses.first : '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registered Users')),
      body: ListView.builder(
        itemCount: registeredUsers.length,
        itemBuilder: (context, index) {
          final user = registeredUsers[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            surfaceTintColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                title: Text(user['usr']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'responses') {
                      _showUserResponsesDialog(context, user['usr']);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'profile',
                      child: Text('View Profile'),
                    ),
                    PopupMenuItem(
                      value: 'responses',
                      child: Text('View Responses'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
