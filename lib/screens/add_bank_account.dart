import 'package:ayu_doctor/models/bank_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBankAccount extends StatefulWidget {
  final String doctorUid;
  const AddBankAccount({Key? key, required this.doctorUid}) : super(key: key);

  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  final TextEditingController accountNumberCtrl = TextEditingController(),
      bankNameCtrl = TextEditingController(),
      branchNameCtrl = TextEditingController(),
      ccOwnerCtrl = TextEditingController();

  /// Create credi card widget
  Padding _createCreditCardWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        height: 360,
        width: 336.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey)),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(height: 300),

              //* acc Number
              Padding(
                padding: const EdgeInsets.only(left: 48.0, top: 30.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: accountNumberCtrl,
                  style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'ACCOUNT NUMBER'),
                ),
              ),

              //* month/year

              Padding(
                padding: const EdgeInsets.only(left: 48.0, top: 90.0),
                child: TextField(
                  controller: bankNameCtrl,
                  style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'BANK NAME'),
                ),
              ),

              //* Branch name

              Padding(
                padding: const EdgeInsets.only(left: 48.0, top: 150.0),
                child: TextField(
                  controller: branchNameCtrl,
                  style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'BRANCH NAME'),
                ),
              ),

              //* Owner
              Padding(
                padding: const EdgeInsets.only(left: 48.0, top: 210),
                child: TextField(
                  controller: ccOwnerCtrl,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'CARD OWNER',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                //* heading
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 30,
                        child: IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_left,
                            size: 35,
                          ),
                          color: const Color.fromARGB(255, 43, 42, 42),
                          //to go back
                          onPressed: () => Navigator.of(context).pop(),
                          // onPressed: () {},
                        ),
                      ),
                      //*title area
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 30.0, bottom: 10),
                        child: const Text(
                          'Add Bank account details',
                          style: TextStyle(
                            fontSize: 24.5,
                            color: Color.fromARGB(255, 48, 47, 47),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                //*master card
                _createCreditCardWidget(),

                //* scan cc
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [],
                      ),
                    ),
                  ),
                ),

                //* add credit card button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: const Text(
                        'Add new account',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 43, 42, 42),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      width: 40,
                      height: 40,
                      child: Builder(
                        builder: (context) {
                          return IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
                            color: const Color.fromARGB(255, 8, 8, 8),
                            //to go back
                            onPressed: () async {
                              if (ccOwnerCtrl.text == "" ||
                                  accountNumberCtrl.text == "" ||
                                  bankNameCtrl.text == "" ||
                                  branchNameCtrl.text == "") {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        content:
                                            Text("Please input all details"),
                                      );
                                    });
                              } else {
                                final newBank = BankCard(
                                    accountHoldersName: ccOwnerCtrl.text,
                                    accountNumber: accountNumberCtrl.text,
                                    bankName: bankNameCtrl.text,
                                    branchName: branchNameCtrl.text,
                                    docID: "");

                                await addBankDetails(
                                    newBank, widget.doctorUid, context);
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> addBankDetails(
        BankCard newBankCard, String doctorUid, BuildContext context) async =>
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorUid)
        .collection('bank_details')
        .add(newBankCard.toJson())
        .then((value) => Navigator.pop(context));



/// this is for text input formatter for credit card
// class MaskedTextInputFormatter extends TextInputFormatter {
//   final String mask;
//   final String separator;

//   MaskedTextInputFormatter({
//     required this.mask,
//     required this.separator,
//   }) {
//     assert(mask != null);
//     assert(separator != null);
//   }

//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     if (newValue.text.length > 0) {
//       if (newValue.text.length > oldValue.text.length) {
//         if (newValue.text.length > mask.length) return oldValue;
//         if (newValue.text.length < mask.length &&
//             mask[newValue.text.length - 1] == separator) {
//           return TextEditingValue(
//             text:
//                 '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
//             selection: TextSelection.collapsed(
//               offset: newValue.selection.end + 1,
//             ),
//           );
//         }
//       }
//     }
//     return newValue;
//   }
// }
