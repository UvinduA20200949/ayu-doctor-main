import 'package:ayu_doctor/screens/send_otp.dart';
import 'package:ayu_doctor/screens/upload_documents.dart';
// import 'package:ayu_doctor/screens/upload_documents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class CreateAccount extends StatefulWidget {
  final String phone;
  final String firstname;
  final String lastname;
  final String email;
  final String uid;
  // ignore: use_key_in_widget_constructors
  const CreateAccount(
      this.phone, this.firstname, this.lastname, this.email, this.uid);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController slmcController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController speciallController = TextEditingController();
  TextEditingController unversityController = TextEditingController();
  TextEditingController qualifyController = TextEditingController();
  TextEditingController consultController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  int _value = 1;
  String phone = '';
  String firstname = '';
  String lastname = '';
  String email = '';
  String address = '';
  String slmc = '';
  String speciality = '';
  String uid = '';
  bool isValidated = false;

  String drOrProf = "";
  bool isEmptyProfession = false;

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    slmcController.dispose();
    speciallController.dispose();
    unversityController.dispose();
    qualifyController.dispose();
    consultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.firstname.isEmpty
        ? null
        : firstnameController.text = widget.firstname;
    widget.lastname.isEmpty ? null : lastnameController.text = widget.lastname;
    widget.email.isEmpty ? null : emailController.text = widget.email;
    widget.phone.isEmpty ? null : phoneController.text = widget.phone;
    widget.uid.isEmpty ? null : uid = widget.uid;

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(alignment: Alignment.center, children: [
        Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
            height: _height * 0.5,
            width: _width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primaryColor, secondaryColor],
                stops: [0.3, 1],
              ),
            ),
          ),
        ]),
        Positioned(
          top: _height * 0.07,
          child: Card(
              elevation: 10,
              shadowColor: iconBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              child: Container(
                  width: _width * 0.9,
                  height: _height,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: LayoutBuilder(
                      builder: (context, constraints) => SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: constraints.maxHeight * 0.15,
                                      width: constraints.maxWidth,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/app_icon.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.03,
                                  ),
                                  const Text(
                                    'Create a new account',
                                    style: TextStyle(
                                      fontFamily: 'InterBold',
                                      fontSize: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.05,
                                    // width: constraints.maxWidth,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Card(
                                          elevation: 5,
                                          shadowColor: iconBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: SizedBox(
                                            height: constraints.maxWidth * 0.23,
                                            width: constraints.maxWidth * 0.2,
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    drOrProf = 'doctor';
                                                    isEmptyProfession = false;
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0))),
                                                  backgroundColor: drOrProf ==
                                                          "doctor"
                                                      ? MaterialStateProperty
                                                          .all(Colors.amber)
                                                      : MaterialStateProperty
                                                          .all(secondaryColor),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    SizedBox(
                                                        child: ImageIcon(
                                                      AssetImage(
                                                          'assets/icons/stethoscope.png'),
                                                      color: Colors.white,
                                                    )),
                                                    Text(
                                                      'Dr.',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontFamily: 'InterBold',
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: _width * 0.02,
                                        ),
                                        Card(
                                          elevation: 5,
                                          shadowColor: iconBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: SizedBox(
                                            height: constraints.maxWidth * 0.23,
                                            width: constraints.maxWidth * 0.2,
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    drOrProf = 'professor';
                                                    isEmptyProfession = false;
                                                  });
                                                },
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0))),
                                                    backgroundColor: drOrProf ==
                                                            "professor"
                                                        ? MaterialStateProperty
                                                            .all(Colors.amber)
                                                        : MaterialStateProperty
                                                            .all(
                                                                secondaryColor)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: const [
                                                    SizedBox(
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            'assets/icons/mortarboard.png'),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Prof.',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontFamily: 'InterBold',
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isEmptyProfession == false
                                      ? const SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Please select your Profession",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            SizedBox(),
                                          ],
                                        ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.05,
                                  ),
                                  Form(
                                    key: _key,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'First Name*',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: firstnameController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: validateFirstname,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter First Name',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.03,
                                        ),
                                        const Text(
                                          'Last Name*',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: lastnameController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: validateLastname,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter Last Name',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.03,
                                        ),
                                        const Text(
                                          'Email*',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: emailController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: validateEmail,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter Your Email',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.03,
                                        ),
                                        const Text(
                                          'Phone Number*',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          readOnly: true,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SendOtp(
                                                  firstnameController.text,
                                                  lastnameController.text,
                                                  emailController.text,
                                                ),
                                              ),
                                            );
                                          },
                                          controller: phoneController,
                                          validator: validatePhoneNumber,
                                          decoration: const InputDecoration(
                                              hintText:
                                                  'Enter Your Phone Number',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.02,
                                        ),
                                        const Text(
                                          'SLMC*',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: slmcController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: validateSLMC,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter SLMC',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.02,
                                        ),
                                        const Text(
                                          'Address',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: addressController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: validateAddress,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter Address',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.02,
                                        ),
                                        const Text(
                                          'Speciality*',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: speciallController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: validateSpecial,
                                          decoration: const InputDecoration(
                                              hintText:
                                                  'Eg : General Practitioner,Pediatrician',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.02,
                                        ),
                                        const Text(
                                          'Medical School/ University',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: unversityController,
                                          validator: validateUniversity,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter Answer',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.01,
                                        ),
                                        const Text(
                                          'For Specialisation Are You',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Text(
                                          'PGIM Board certified',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                                value: 1,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = 1;
                                                  });
                                                }),
                                            SizedBox(
                                              width: _width * 0.01,
                                            ),
                                            const Text(
                                              'Yes',
                                              style: TextStyle(
                                                fontFamily: 'InterMedium',
                                                fontSize: 17,
                                                color: primaryText,
                                              ),
                                            ),
                                            Radio(
                                                value: 2,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = 2;
                                                  });
                                                }),
                                            SizedBox(
                                              width: _width * 0.01,
                                            ),
                                            const Text(
                                              'No',
                                              style: TextStyle(
                                                fontFamily: 'InterMedium',
                                                fontSize: 17,
                                                color: primaryText,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.01,
                                        ),
                                        const Text(
                                          'Qualification',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: qualifyController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: validateQualify,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter Qualification',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.01,
                                        ),
                                        const Text(
                                          'How much would you like to charge Per',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Text(
                                          'Consultation',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextFormField(
                                          controller: consultController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: validateConsult,
                                          decoration: const InputDecoration(
                                              hintText: 'Eg: 500/=',
                                              hintStyle: TextStyle(
                                                fontFamily: 'InterBold',
                                                color: Colors.grey,
                                              )),
                                          maxLines: 1,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^\d+\.?\d{0,2}')),
                                          ],
                                          textInputAction: TextInputAction.done,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.04,
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: _width * 0.5,
                                            height: _height * 0.07,
                                            child: TextButton(
                                                onPressed: moveToNextScreen,
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                  ),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          secondaryColor),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    const Text(
                                                      'Next',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontFamily: 'InterBold',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: _width * 0.08,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      child: Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            0.2,
                                                        width: constraints
                                                                .maxWidth *
                                                            0.2,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white,
                                                        ),
                                                        child: const Icon(
                                                          Icons
                                                              .arrow_forward_rounded,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.05,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom)),
                                      ],
                                    ),
                                  )
                                ]),
                          )))),
        )
      ]),
    );
  }

  checkvalidation() {
    if (_key.currentState!.validate()) {
      setState(() {
        isValidated = true;
      });
    } else {
      setState(() {
        isValidated = false;
      });
    }
  }

  Future moveToNextScreen() async {
    checkvalidation();
    if (drOrProf == "") {
      setState(() {
        isEmptyProfession = true;
      });
    } else if (isValidated) {
      double consultationFee = double.parse(consultController.text);
      double consultationFeeConverted =
          double.parse((consultationFee).toStringAsFixed(2));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UploadDocuments(
                  firstname: firstnameController.text,
                  lastname: lastnameController.text,
                  email: emailController.text,
                  phone: '+94${phoneController.text}',
                  address: addressController.text,
                  slmc: slmcController.text,
                  speciality: speciallController.text,
                  university: unversityController.text,
                  qualify: qualifyController.text,
                  consult: consultationFeeConverted,
                  isPgimCertified: _value == 1 ? true : false,
                  uid: uid,
                  profession: drOrProf)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: secondaryColor,
          content: Text(
            "Fields can't be empty",
            style: TextStyle(
              fontFamily: 'InterMedium',
              color: Colors.white,
            ),
          )));
    }
  }

  String? validateEmail(String? formEmail) {
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);

    if (formEmail == null || formEmail.isEmpty) {
      return "Field can't be empty";
    } else if (!regex.hasMatch(formEmail)) {
      return "Provide a valid email";
    }

    return null;
  }

  String? validateFirstname(String? formFirstname) {
    String pattern = '[a-zA-Z]';
    RegExp nameRegExp = RegExp(pattern);
    if (formFirstname == null ||
        formFirstname.isEmpty ||
        !nameRegExp.hasMatch(formFirstname)) {
      return "Field can't be empty";
    }
    return null;
  }

  String? validateLastname(String? formLastname) {
    String pattern = '[a-zA-Z]';
    RegExp nameRegExp = RegExp(pattern);
    if (formLastname == null ||
        formLastname.isEmpty ||
        !nameRegExp.hasMatch(formLastname)) {
      return "Field can't be empty";
    }
    return null;
  }

  String? validateSLMC(String? formSLMC) {
    String pattern = '[a-zA-Z]';
    RegExp regex = RegExp(pattern);
    if (formSLMC == null || formSLMC.isEmpty) {
      return "Field can't be empty";
    } else if (!regex.hasMatch(formSLMC)) {
      return 'Provide a valid SLMC';
    } else {
      return null;
    }
  }

  String? validateAddress(String? formAddress) {
    String pattern = '^(.+)[,\\s]+(.+?)s*(d{5})?';
    RegExp regex = RegExp(pattern);
    if (formAddress == null || formAddress.isEmpty) {
      return "Field can't be empty";
    } else if (!regex.hasMatch(formAddress)) {
      return "Provide a valid Address";
    }
    return null;
  }

  String? validateSpecial(String? formSpecial) {
    String pattern = '[a-zA-Z]';
    RegExp nameRegExp = RegExp(pattern);
    if (formSpecial == null ||
        formSpecial.isEmpty ||
        !nameRegExp.hasMatch(formSpecial)) {
      return "Field can't be empty";
    }
    return null;
  }

  String? validateUniversity(String? formUniversity) {
    if (formUniversity == null || formUniversity.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  String? validateQualify(String? formQualify) {
    if (formQualify == null || formQualify.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  String? validateConsult(String? formConsult) {
    if (formConsult == null || formConsult.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  String? validatePhoneNumber(String? formPhoneNumber) {
    if (formPhoneNumber == null || formPhoneNumber.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }
}
