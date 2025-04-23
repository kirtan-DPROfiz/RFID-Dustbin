import 'package:flutter/material.dart';

import '../../Footer/footer.dart';

class UserDetailsForm extends StatefulWidget {
  const UserDetailsForm({super.key});

  @override
  State<UserDetailsForm> createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _contactPersonNameController =
      TextEditingController();
  final TextEditingController _contactPersonMobileController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _numDustbinsController = TextEditingController();
  final TextEditingController _numFloorsController = TextEditingController();

  @override
  void dispose() {
    _organizationNameController.dispose();
    _contactPersonNameController.dispose();
    _contactPersonMobileController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _numDustbinsController.dispose();
    _numFloorsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Form submitted successfully!'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 32,
              vertical: 20,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(isMobile ? 20 : 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(isMobile),
                      const SizedBox(height: 32),
                      if (isMobile)
                        _buildMobileLayout()
                      else if (isTablet)
                        _buildTabletLayout()
                      else
                        _buildDesktopLayout(),
                      const SizedBox(height: 32),
                      _buildSubmitButton(isMobile),
                      const SizedBox(height: 40),
                      FooterWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.only(bottom: isMobile ? 16 : 24),
          color: Colors.white,
          elevation: 4,
          child: Padding(
              padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/DprofizLogo.png",
                    height: isMobile ? 50 : 60,
                  ),
                  Text(
                    "DPROFIZ.PVT.LTD",
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 16),
        Text(
          "Organization Registration",
          style: TextStyle(
            fontSize: isMobile ? 22 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Please provide your organization details",
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildSection(
          title: "Organization Info",
          children: [
            _buildTextFormField(
              controller: _organizationNameController,
              label: "Organization Name",
              isRequired: true,
            ),
            _buildTextFormField(
              controller: _addressController,
              label: "Address",
              isRequired: true,
              maxLines: 2,
            ),
            _buildTextFormField(
              controller: _areaController,
              label: "Area",
              isRequired: true,
            ),
            _buildTextFormField(
              controller: _cityController,
              label: "City",
              isRequired: true,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          title: "Facility Details",
          children: [
            _buildTextFormField(
              controller: _numDustbinsController,
              label: "Number of Dustbins",
              isRequired: true,
              keyboardType: TextInputType.number,
            ),
            _buildTextFormField(
              controller: _numFloorsController,
              label: "Number of Floors",
              isRequired: true,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          title: "Contact Info",
          children: [
            _buildTextFormField(
              controller: _contactPersonNameController,
              label: "Contact Person",
              isRequired: true,
            ),
            _buildTextFormField(
              controller: _contactPersonMobileController,
              label: "Contact Mobile",
              isRequired: true,
              keyboardType: TextInputType.phone,
            ),
            _buildTextFormField(
              controller: _emailController,
              label: "Email",
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
            ),
            _buildTextFormField(
              controller: _phoneNumberController,
              label: "Phone Number",
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        // First Row - Organization and Facility Details
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildSection(
                title: "Organization Info",
                children: [
                  _buildTextFormField(
                    controller: _organizationNameController,
                    label: "Organization Name",
                    isRequired: true,
                  ),
                  _buildTextFormField(
                    controller: _addressController,
                    label: "Address",
                    isRequired: true,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: _buildSection(
                title: "Facility Details",
                children: [
                  _buildTextFormField(
                    controller: _numDustbinsController,
                    label: "Number of Dustbins",
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextFormField(
                    controller: _numFloorsController,
                    label: "Number of Floors",
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Second Row - Location and Contact
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildSection(
                title: "Location",
                children: [
                  _buildTextFormField(
                    controller: _areaController,
                    label: "Area",
                    isRequired: true,
                  ),
                  _buildTextFormField(
                    controller: _cityController,
                    label: "City",
                    isRequired: true,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildSection(
                title: "Contact Info",
                children: [
                  _buildTextFormField(
                    controller: _contactPersonNameController,
                    label: "Contact Person",
                    isRequired: true,
                  ),
                  _buildTextFormField(
                    controller: _contactPersonMobileController,
                    label: "Contact Mobile",
                    isRequired: true,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Full width row for email and phone
        _buildSection(
          title: "Additional Contact",
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextFormField(
                    controller: _emailController,
                    label: "Email",
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextFormField(
                    controller: _phoneNumberController,
                    label: "Phone Number",
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        // First Row - Organization and Contact
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildSection(
                title: "Organization Information",
                children: [
                  _buildTextFormField(
                    controller: _organizationNameController,
                    label: "Organization Name",
                    isRequired: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextFormField(
                          controller: _areaController,
                          label: "Area",
                          isRequired: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextFormField(
                          controller: _cityController,
                          label: "City",
                          isRequired: true,
                        ),
                      ),
                    ],
                  ),
                  _buildTextFormField(
                    controller: _addressController,
                    label: "Address",
                    isRequired: true,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildSection(
                title: "Primary Contact",
                children: [
                  _buildTextFormField(
                    controller: _contactPersonNameController,
                    label: "Contact Person Name",
                    isRequired: true,
                  ),
                  _buildTextFormField(
                    controller: _contactPersonMobileController,
                    label: "Contact Mobile",
                    isRequired: true,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextFormField(
                    controller: _contactPersonNameController,
                    label: "UserId",
                    isRequired: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextFormField(
                          controller: _emailController,
                          label: "Email",
                          isRequired: true,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextFormField(
                          controller: _phoneNumberController,
                          label: "Phone Number",
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Second Row - Facility Details
        _buildSection(
          title: "Facility Details",
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextFormField(
                    controller: _numDustbinsController,
                    label: "Number of Dustbins",
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextFormField(
                    controller: _numFloorsController,
                    label: "Number of Floors",
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: '$label${isRequired ? ' *' : ''}',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Required field';
          }
          if (keyboardType == TextInputType.emailAddress &&
              value != null &&
              value.isNotEmpty &&
              !_isValidEmail(value)) {
            return 'Enter valid email';
          }
          if (keyboardType == TextInputType.phone &&
              value != null &&
              value.isNotEmpty &&
              !_isValidPhoneNumber(value)) {
            return 'Enter valid phone';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton(bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : null,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          shadowColor: Colors.deepPurple.withOpacity(0.3),
        ),
        child: Text(
          "Submit",
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    return RegExp(r'^[0-9]{10,}$').hasMatch(phone);
  }
}
