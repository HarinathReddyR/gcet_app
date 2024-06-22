// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'bloc/postevents_bloc.dart';

class PostEventsPage extends StatelessWidget {
  const PostEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Events',
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key, // Ensure GetX is properly initialized
      home: BlocProvider(
        create: (_) => PostEventsBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  late DateTime _selectedDateTime;
  DateTime today = DateTime.now();

  void selectImages() async {
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

  Widget imageDisplay() {
    return SizedBox(
      height: 200,
      child: imageFileList == null || imageFileList!.isEmpty
          ? Container()
          : ImageSlideshow(
              width: double.infinity,
              height: 200,
              initialPage: 0,
              indicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              children: imageFileList!.map((img) {
                return Image.network(img.path);
              }).toList(),
              onPageChanged: (value) {
                print('Page changed: $value');
              },
            ),
    );
  }

  Widget bottomNav(PostEventsBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Image.asset('lib/assets/photoicon.png', width: 50, height: 30),
          onPressed: selectImages,
        ),
        SizedBox(
          height: 40.0,
          width: 100.0,
          child: ElevatedButton(
            onPressed: () {
              try {
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            shape: CircleBorder(),
                            surfaceTintColor: Colors.red,
                            child: Text(
                              '?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                              ),
                            )
                          ),
                          const Text(
                            "Title Text",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Message Text",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('NO'),
                                  onPressed: () {
                                    Get.back(); // Close the dialog
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('YES'),
                                  onPressed: () {
                                    Get.back(); // Close the dialog
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } catch (e) {
                print('Error showing dialog: $e');
              }
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
                SnackBar(content: Text('Failed to post event: ${state.error}')),
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
      ),
    );
  }
}
