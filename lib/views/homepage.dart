import 'package:flutter/material.dart';
import 'package:script_ease/service/sheet_api.dart';
import 'package:script_ease/views/feedback_list.dart';
import 'package:script_ease/model/form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        emailController.text,
        mobileNoController.text,
        feedbackController.text,
      );

      SheetAPI sheetAPI = SheetAPI();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Submitting Feedback...')));

      sheetAPI.submitForm(feedbackForm, (String response) {
        if (response == SheetAPI.STATUS_SUCCESS) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Feedback Submitted Successfully')),
          );
          _formKey.currentState!.reset();
          nameController.clear();
          emailController.clear();
          mobileNoController.clear();
          feedbackController.clear();
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error Occurred!')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackListPage(title: ''),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator:
                    (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                controller: mobileNoController,
                decoration: InputDecoration(labelText: 'Mobile No'),
                validator:
                    (value) =>
                        value!.isEmpty
                            ? 'Please enter your mobile number'
                            : null,
              ),
              TextFormField(
                controller: feedbackController,
                decoration: InputDecoration(labelText: 'Feedback'),
                validator:
                    (value) => value!.isEmpty ? 'Please enter feedback' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  elevation: 1.5,
                ),
                child: Text('Submit Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
