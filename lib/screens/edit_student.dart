import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sq_flite/db/functions/functions.dart';
import 'package:sq_flite/db/model/model.dart';

class EditStudent extends StatefulWidget {
  final StudentModel data;
  const EditStudent({super.key, required this.data});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  String? image;
  String? newImage;
  int? id;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.data.name);
    _ageController = TextEditingController(text: widget.data.age);
    _mobileController = TextEditingController(text: widget.data.mobile);
    image = widget.data.image;
    id = widget.data.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white54,
        centerTitle: true,
        title: const Text(
          'Edit',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 250,
                  color: Colors.grey[400],
                  child: newImage != null
                      ? Image.file(File(newImage!))
                      : Image.file(File(image!)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _imageFromCam();
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.camera,size: 70,)),
                                            const Text('camera'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _imageFromGal();
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.image,size: 70,)),
                                            const Text('Gallery')
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      label: const Text('chose Photo'),
                      icon: const Icon(Icons.camera)),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter the name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter the Age';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'mobile',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter mobile number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onEditStudentButtonClicked();
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onEditStudentButtonClicked() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final mobile = _mobileController.text.trim();
    if (name.isEmpty || age.isEmpty || mobile.isEmpty) {
      return;
    }

    final student = StudentModel(
        name: name,
        age: age,
        mobile: mobile,
        image: (newImage == null) ? image! : newImage!);
    await updateStudent(student);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

// pick image From gallery
  Future _imageFromGal() async {
    final fetchedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (fetchedImage == null) return;
    setState(() {
      newImage = fetchedImage.path;
    });
  }

// pick image From camera
  Future _imageFromCam() async {
    final fetchedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (fetchedImage == null) return;
    setState(() {
      newImage = fetchedImage.path;
    });
  }
}
