import 'package:ayu_doctor/models/bank_card.dart';
import 'package:ayu_doctor/screens/add_bank_account.dart';
import 'package:ayu_doctor/screens/earnings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/colors.dart';
import 'package:flutter/material.dart';

class BankAccount extends StatefulWidget {
  final String doctorUid;
  const BankAccount({Key? key, required this.doctorUid}) : super(key: key);

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            height: _height * 0.2,
            width: _width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryColor, secondaryColor]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                )),
            child: LayoutBuilder(
                builder: (context, constraints) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, top: 35),
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                'Bank Account',
                                style: TextStyle(
                                  fontFamily: 'InterBold',
                                  fontSize: 27,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
          ),
          SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      StreamBuilder<List<BankCard>?>(
                          stream: getBankCards(widget.doctorUid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final listData = snapshot.data;

                              if (listData!.isEmpty) {
                                return Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Center(
                                        child: Text(
                                            "No bank account details to show"),
                                      ),
                                    ),
                                    AddBankAccountButton(
                                        num: 0,
                                        doctorUID: widget.doctorUid,
                                        docID: ""),
                                  ],
                                );
                              }
                              if (listData.isNotEmpty) {
                                return Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: listData.length,
                                        itemBuilder: ((context, index) {
                                          return CreditCard(
                                            bankCard: listData[index],
                                          );
                                        })),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    AddBankAccountButton(
                                        num: 1,
                                        doctorUID: widget.doctorUid,
                                        docID: listData[0].docID),
                                  ],
                                );
                              }
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData) {
                              return const Text("No Data");
                            }
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return const CircularProgressIndicator();
                          }),
                      const SizedBox(
                        height: 50,
                      ),
                      // ignore: deprecated_member_use
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddBankAccountButton extends StatelessWidget {
  final int num;
  final String doctorUID, docID;
  const AddBankAccountButton({
    Key? key,
    required this.num,
    required this.doctorUID,
    required this.docID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (num == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddBankAccount(
                        doctorUid: doctorUID,
                      )));
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Delete"),
                    content: const Text("Do you want to delete old account ?"),
                    actions: [
                      TextButton(
                        child: const Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text("Yes"),
                        onPressed: () async {
                          await deleteBankCards(doctorUID, docID);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBankAccount(
                                doctorUid: doctorUID,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ));
        }
      },
      color: secondaryColor,
      child: const SizedBox(
        height: 55,
        child: Center(
            child: Text(
          "Add new bank account",
          style: TextStyle(
            fontFamily: "InterMedium",
            fontSize: 17,
            color: Colors.white,
          ),
        )),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

Stream<List<BankCard>?> getBankCards(String doctorUid) => FirebaseFirestore
    .instance
    .collection('doctors')
    .doc(doctorUid)
    .collection('bank_details')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((e) => BankCard.fromJson(e.data(), e.id)).toList());

//delete the bank account
Future<void> deleteBankCards(String doctorUid, String docID) =>
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorUid)
        .collection('bank_details')
        .doc(docID)
        .delete();

class CreditCard extends StatelessWidget {
  final BankCard bankCard;
  const CreditCard({Key? key, required this.bankCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        height: 220.0,
        width: 336.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[850],
        ),
        child: Stack(
          children: [
            Positioned(
                left: 35,
                top: 15,
                child: Image.asset(
                  'assets/images/credit.png',
                  width: 33,
                  height: 33,
                )),

            //* card number
            Positioned(
              left: 35,
              top: 60,
              child: Text(
                // creditCard.cardNumber,
                bankCard.accountNumber,
                style: const TextStyle(
                    fontFamily: "InterBold",
                    fontSize: 25.0,
                    color: Colors.white),
              ),
            ),

            //* exp date
            const Positioned(
                left: 35,
                top: 110,
                child: Text(
                  'Bank Name',
                  style: TextStyle(
                    fontFamily: "InterBold",
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )),
            Positioned(
                left: 35,
                top: 140,
                child: Text(
                  // creditCard.bankName,
                  bankCard.bankName,
                  style: const TextStyle(
                      fontFamily: "InterBold",
                      color: Colors.white,
                      fontSize: 15),
                )),
            //* ccv
            const Positioned(
                left: 211,
                top: 110,
                child: Text(
                  'Branch Name',
                  style: TextStyle(
                      fontFamily: "InterMedium",
                      color: Colors.white,
                      fontSize: 15),
                )),
            Positioned(
                left: 211,
                top: 140,
                child: Text(
                  bankCard.branchName,
                  style: const TextStyle(
                      fontFamily: "InterMedium",
                      color: Colors.white,
                      fontSize: 15),
                )),
            //* owner
            Positioned(
                left: 35,
                top: 167,
                child: Text(
                  bankCard.accountHoldersName,
                  style: const TextStyle(
                      fontFamily: "InterMedium",
                      color: Colors.white,
                      fontSize: 15),
                )),
          ],
        ),
      ),
    );
  }
}
