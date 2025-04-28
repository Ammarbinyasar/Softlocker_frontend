import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set to transparent
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Gradient Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 146, 225, 226), // rgb(146, 225, 226)
              Color.fromARGB(255, 13, 70, 113), // rgb(13, 70, 113)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Profile Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Profile Info Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: const Color(0xFF1C3C83),
                      width: 2,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // DOB Input
                      Row(
                        children: [
                          const Text('DOB', style: _labelStyle),
                          const SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  dobController.text =
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: dobController,
                                  decoration: const InputDecoration(
                                    hintText: 'DD-MM-YYYY',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black, height: 32),

                      // Gender Input
                      Row(
                        children: [
                          const Text('Gender', style: _labelStyle),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Male',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Male'),
                                Radio<String>(
                                  value: 'Female',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Female'),
                                Radio<String>(
                                  value: 'Prefer not to say',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text('Prefer not to say'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black, height: 32),

                      // Phone Input
                      Row(
                        children: [
                          const Text('Phone', style: _labelStyle),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: '91+ ##########',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black, height: 32),

                      // Email Input
                      Row(
                        children: [
                          const Text('Email', style: _labelStyle),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Example@gmail.com',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Sign Out Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Sign-out action (not implemented)
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D1212),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const _labelStyle = TextStyle(
  fontFamily: 'Urbanist',
  fontWeight: FontWeight.bold,
  fontSize: 15,
);
