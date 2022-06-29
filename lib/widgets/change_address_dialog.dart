// import 'package:ayu_app/utils/colors.dart';
import 'package:ayu_doctor/utils/colors.dart';
// import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

showChangeAddressDialog(BuildContext context) {
  final _height = MediaQuery.of(context).size.height;
  final _width = MediaQuery.of(context).size.width;
  return showDialog(
      context: context,
      builder: (BuildContext c) {
        return Dialog(
            alignment: Alignment.center,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
                width: _width * 0.9,
                height: _height * 0.53,
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: LayoutBuilder(
                    builder: (context, constraints) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: const TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: primaryText,
                                      fontFamily: 'InterMedium',
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: 'Address Line 01',
                                    hintStyle: TextStyle(
                                      fontFamily: 'InterMedium',
                                      color: secondaryText,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: secondaryColor,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.03,
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: const TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: primaryText,
                                      fontFamily: 'InterMedium',
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: 'Address Line 02',
                                    hintStyle: TextStyle(
                                      fontFamily: 'InterMedium',
                                      color: secondaryText,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: secondaryColor,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.03,
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: const TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: primaryText,
                                      fontFamily: 'InterMedium',
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: 'Address Line 03',
                                    hintStyle: TextStyle(
                                      fontFamily: 'InterMedium',
                                      color: secondaryText,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: secondaryColor,
                                  maxLines: 1,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.03,
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: const TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: primaryText,
                                      fontFamily: 'InterMedium',
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: 'City',
                                    hintStyle: TextStyle(
                                      fontFamily: 'InterMedium',
                                      color: secondaryText,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: secondaryColor,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.03,
                              ),
                              // Container(
                              //     alignment: Alignment.center,
                              //     margin: const EdgeInsets.symmetric(
                              //         horizontal: 20),
                              //     decoration: BoxDecoration(
                              //         color: Colors.grey.withOpacity(0.1),
                              //         borderRadius: const BorderRadius.all(
                              //             Radius.circular(10))),
                              //     child: CountryCodePicker(
                              //       initialSelection: 'Sri Lanka',
                              //       showCountryOnly: false,
                              //       showOnlyCountryWhenClosed: false,
                              //       favorite: const ['+94', 'Sri Lanka'],
                              //       enabled: true,
                              //       hideMainText: false,
                              //       showFlagMain: true,
                              //       showFlag: true,
                              //       hideSearch: false,
                              //       showFlagDialog: true,
                              //       alignLeft: true,
                              //       padding: const EdgeInsets.all(10),
                              //     )),
                              SizedBox(
                                height: constraints.maxHeight * 0.08,
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.6,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              secondaryColor),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text(
                                          'Update',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'InterBold',
                                          ),
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth * 0.02,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    )),
                              ),
                            ]))));
      });
}
