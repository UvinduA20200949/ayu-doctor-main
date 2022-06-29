import 'dart:io';
import 'dart:ui';
import 'dart:isolate';

import 'package:ayu_doctor/backend/chat_service.dart';
import 'package:ayu_doctor/models/chat_message.dart';
import 'package:ayu_doctor/models/patient.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../utils/colors.dart';

class Chat extends StatefulWidget {
  final Patient patient;
  const Chat({Key? key, required this.patient}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController textMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      DownloadTaskStatus status = data[1];

      if (status == DownloadTaskStatus.complete) {
        debugPrint("Download Completed");
      }

      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    textMessageController.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  int progress = 0;

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            height: _height * 0.15,
            width: _width,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [quaternaryColor, primaryColor]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )),
            child: LayoutBuilder(
              builder: (context, constraints) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: constraints.maxWidth * 0.07,
                        height: constraints.maxWidth * 0.07,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 17,
                          color: quaternaryColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: constraints.maxWidth * 0.2,
                            width: constraints.maxWidth * 0.2,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: iconBackgroundColor,
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/doctor_male.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            top: constraints.maxHeight * 0.02,
                            left: constraints.maxWidth * 0.03,
                            child: Container(
                                height: constraints.maxHeight * 0.25,
                                width: constraints.maxHeight * 0.25,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: tertiaryColor)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.patient.name,
                      style: const TextStyle(
                        fontFamily: 'InterBold',
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            reverse: true,
            child: StreamBuilder<List<ChatMessage>>(
                stream: BookingBackend().readChats(widget.patient.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const AlertDialog(
                      content: Text("Something went wrong"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    final messageList = snapshot.data;

                    //sorting message list
                    messageList?.sort((a, b) => a.time.compareTo(b.time));

                    return ListView.separated(
                        reverse: false,
                        controller: _scrollController,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                        itemCount: messageList!.length,
                        itemBuilder: (context, int index) {
                          return ChatMessageWidget(
                            messageList: messageList,
                            width: _width,
                            index: index,
                          );
                        });
                  }

                  return const CircularProgressIndicator();
                }),
          )),
          const SizedBox(
            height: 20,
          ),
          if (pickedFile != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              // height: _height / 4,
              width: _width,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Stack(
                  // overflow: Overflow.visible,

                  // fit: StackFit.expand,
                  children: [
                    Center(
                      child: pickedFile!.extension! == 'jpg'
                          ? Image.file(
                              File(pickedFile!.path!),
                              width: _width * 0.6,
                              // height: 100,
                            )
                          : Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.blue),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.file_copy),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    pickedFile!.name,
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Positioned(
                      top: 0,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pickedFile = null;
                          });
                        },
                        child: const Icon(Icons.cancel, size: 30),
                      ),
                    ),
                    buildProgress(),
                  ]),
            ),
          Container(
              width: _width,
              height: _height * 0.08,
              color: secondaryColor,
              child: LayoutBuilder(
                builder: (context, constraints) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth * 0.71,
                      margin: const EdgeInsets.only(left: 15, right: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          //text input
                          child: TextField(
                            style: const TextStyle(
                                color: primaryText,
                                fontFamily: 'InterMedium',
                                fontSize: 17),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            cursorColor: tertiaryColor,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            controller: textMessageController,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectFile();
                      },
                      child: Container(
                        height: constraints.maxHeight * 0.55,
                        width: constraints.maxHeight * 0.55,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/attach.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        BookingBackend().sendMessage(textMessageController.text,
                            widget.patient.uid, pickedFile, uploadTask);
                        textMessageController.clear();
                        pickedFile = null;
                        if (_scrollController.hasClients) {
                          final position =
                              _scrollController.position.maxScrollExtent;
                          _scrollController.jumpTo(position);
                        }

                        setState(() {
                          textMessageController.text = "";
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: constraints.maxHeight * 0.55,
                        width: constraints.maxHeight * 0.55,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/send.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ]));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      });
}

//single chat message
class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key? key,
    required this.messageList,
    required double width,
    required this.index,
  })  : _width = width,
        super(key: key);

  final List<ChatMessage>? messageList;
  final double _width;
  final int index;
  @override
  Widget build(BuildContext context) {
    final timeAndDateMessage = messageList![index].time.toDate();
    return Container(
      padding: const EdgeInsets.all(10),
      margin: (messageList![index].sendBy) == "doctor"
          ? EdgeInsets.fromLTRB((_width / 2.5), 0, 10, 0)
          : EdgeInsets.fromLTRB(10, 0, (_width / 2.5), 0),
      decoration: BoxDecoration(
        color: (messageList![index].sendBy) == "doctor"
            ? Colors.green
            : Colors.blue,
        borderRadius: messageList![index].documents != ""
            ? const BorderRadius.all(Radius.circular(5))
            : const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          messageList![index].text! == ""
              ? const SizedBox()
              : Text(
                  messageList![index].text!,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
          messageList![index].documents != ""
              ? Container(
                  child: Column(children: [
                    InkWell(
                      onTap: (() {
                        // downloadFileInChat(messageList![index].documents!);
                        BookingBackend().downloadFileInChatt(
                            messageList![index].documents!);
                      }),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        imageUrl: messageList![index].documents!,
                        errorWidget: (context, url, error) => const Text(
                            "Download PDF File.",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ]),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ))
              : Container(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                "${timeAndDateMessage.hour} : ${timeAndDateMessage.minute < 10 ? 0.toString() + timeAndDateMessage.minute.toString() : timeAndDateMessage.minute} ",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )
          // Text(
          //     "${messageList![index].time.toDate()}"),
        ],
      ),
    );
  }
}



/*

//single chat message
class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key? key,
    required this.messageList,
    required double width,
    required this.index,
  })  : _width = width,
        super(key: key);

  final List<ChatMessage>? messageList;
  final double _width;
  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: (messageList![index].sendBy) == "doctor"
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
            // margin: (messageList![index].sendBy) == "doctor"
            //     ? EdgeInsets.fromLTRB((_width / 2.5), 0, 10, 0)
            //     : EdgeInsets.fromLTRB(10, 0, (_width / 2.5), 0),
            decoration: BoxDecoration(
              color: (messageList![index].sendBy) == "doctor"
                  ? Colors.green
                  : Colors.blue,
              borderRadius: messageList![index].documents != ""
                  ? const BorderRadius.all(Radius.circular(5))
                  : const BorderRadius.all(Radius.circular(50)),
            ),
            child: Column(
              children: [
                messageList![index].text! == ""
                    ? const SizedBox()
                    : Text(
                        messageList![index].text!,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                messageList![index].documents != ""
                    ? Container(
                        // height: size.height / 4,
                        width: size.width / 1.5,
                        child: Column(children: [
                          InkWell(
                            onTap: (() async {
                              // downloadFileInChat(
                              //     messageList[index].documents!);
                            }),
                            child: CachedNetworkImage(
                              fit: BoxFit.fitWidth,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              imageUrl: messageList![index].documents!,
                              errorWidget: (context, url, error) => const Text(
                                  "Download PDF File.",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ]),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ))
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}


*/ 
