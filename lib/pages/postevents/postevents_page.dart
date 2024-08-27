import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/models/customform_ques.dart';
import 'package:gcet_app/pages/postevents/formgenerator.dart';
import 'package:gcet_app/pages/postevents/bloc/postevents_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';

class PostEvents extends StatelessWidget {
  const PostEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PostEventsBloc>(
        create: (context) => PostEventsBloc(),
        child: PostEventsPage(),
      ),
    );
  }
}

class PostEventsPage extends StatefulWidget {
  @override
  State<PostEventsPage> createState() => PostEventsPageState();
}

class PostEventsPageState extends State<PostEventsPage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  late DateTime _selectedDateTime;
  DateTime today = DateTime.now();
  bool reg = false;
  List<Question> ques = [];

  Future<void> selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList!.addAll(selectedImages);
      });
    }
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: today.add(const Duration(days: 1)),
      firstDate: today.add(const Duration(days: 1)),
      lastDate: DateTime(_selectedDate.year + 1),
    );

    if (newSelectedDate != null) {
      TimeOfDay? newSelectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (newSelectedTime != null) {
        _selectedDateTime = DateTime(
          newSelectedDate.year,
          newSelectedDate.month,
          newSelectedDate.day,
          newSelectedTime.hour,
          newSelectedTime.minute,
        );

        setState(() {
          dateController.text =
              '${DateFormat.yMMMd().format(_selectedDateTime)} @ ${DateFormat.jm().format(_selectedDateTime)}';
          dateController.selection = TextSelection.fromPosition(
            TextPosition(
              offset: dateController.text.length,
              affinity: TextAffinity.upstream,
            ),
          );
        });
      }
    }
  }

  Future dialogBox(PostEventsBloc bloc) {
    String dial = (reg)
        ? 'Do you want to post with Registration form ?'
        : 'Do you want to post without Registration form ?';
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(dial,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              if (!reg) ques = [];
                              bloc.add(PostEvent(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  date: dateController.text,
                                  venue: venueController.text,
                                  imageFileList: imageFileList!,
                                  reg: reg,
                                  ques: ques));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
                            ),
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!reg) ques = [];
                              bloc.add(PostEvent(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  date: dateController.text,
                                  venue: venueController.text,
                                  imageFileList: imageFileList!,
                                  reg: reg,
                                  ques: ques));
                              // print("success");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget imageDisplay() {
    return SizedBox(
      height: 200,
      child: imageFileList == null || imageFileList!.isEmpty
          ? Container()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageFileList!.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Image.network(
                        imageFileList![index].path,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            imageFileList!.removeAt(index);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget bottomNav(PostEventsBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Image.asset('lib/assets/photoicon.png',
              width: (MediaQuery.of(context).size.width) / 10, height: 30),
          onPressed: selectImages,
        ),
        SizedBox(
            height: 40.0,
            width: (MediaQuery.of(context).size.width) / 9,
            child: Switch(
              // This bool value toggles the switch.
              value: reg,
              activeColor: Color.fromRGBO(78, 24, 217, 1),
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  reg = value;
                });
              },
            )),
        SizedBox(
          height: 40.0,
          width: (MediaQuery.of(context).size.width) / 3,
          child: ElevatedButton(
            onPressed: !reg
                ? null
                : () async {
                    // Navigate to CustomFormPage and wait for the result
                    ques = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomFormPage(
                                title: titleController.text,
                                desc: descriptionController.text,
                                questions: ques,
                              )),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
            ),
            child: const Text(
              'Generate Form',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
        SizedBox(
          height: 40.0,
          width: (MediaQuery.of(context).size.width) / 4,
          child: ElevatedButton(
            onPressed: () {
              dialogBox(bloc);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
            ),
            child: const Text(
              'Post',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post your Event'),
        ),
        body: SafeArea(
          child: BlocConsumer<PostEventsBloc, PostEventsState>(
            listener: (context, state) {
              if (state is PostEventsSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Event posted successfully')),
                );
              } else if (state is PostEventsFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Failed to post event: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              if (state is PostEventsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final bloc = BlocProvider.of<PostEventsBloc>(context);

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: Column(
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Event Title',
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 45) /
                                          2,
                                  child: TextField(
                                    controller: dateController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Event Date',
                                    ),
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 45) /
                                          2,
                                  child: TextField(
                                    controller: venueController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Venue',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: 'Write your Event Description...',
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (imageFileList != null &&
                                imageFileList!.isNotEmpty)
                              imageDisplay(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Column(
                      children: [
                        bottomNav(bloc),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
