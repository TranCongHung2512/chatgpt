import 'package:client/design/app_colors.dart';
import 'package:client/features/chat/bloc/chat_page_dart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatPageDartBloc chatBloc = ChatPageDartBloc();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF343541), // Màu nền tối giống ChatGPT
      appBar: AppBar(
        backgroundColor: const Color(0xFF444654), // Màu AppBar
        centerTitle: true,
        title: const Text(
          "ChatGPT",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Màu chữ trắng
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Đặt màu icon back thành trắng
        ),
      ),
      body: BlocConsumer<ChatPageDartBloc, ChatPageDartState>(
        bloc: chatBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: chatBloc.cachedMessages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color:
                              chatBloc.cachedMessages[index].role == 'assistant'
                                  ? AppColors.messageBgColor
                                  : Colors.transparent),
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          chatBloc.cachedMessages[index].role == 'assistant'
                              ? Container(
                                  height: 32,
                                  width: 32,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "asset/logochatgpt.jpg",
                                          ),
                                          fit: BoxFit.cover)),
                                )
                              : Container(
                                  height: 32,
                                  width: 32,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("asset/person.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              chatBloc.cachedMessages[index].content,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      promptContainer(("Bạn có biết VKU không?")),
                      promptContainer(("Bạn có biết VKU không?")),
                      promptContainer(("Bạn có biết VKU không?")),
                      promptContainer(("Bạn có biết VKU không?")),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF40414F), // Màu nền cho TextField
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white), // Màu chữ trong TextField
                          decoration: const InputDecoration(
                            hintText: "Ask Anything...",
                            hintStyle: TextStyle(
                                color: Colors.white70), // Màu chữ gợi ý
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            String text = controller.text;
                            controller.clear;
                            chatBloc.add(ChatNewPromptEvent(prompt: text));
                          }
                        },
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white, // Đặt icon gửi màu trắng
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ChatGPT March 2024",
                        style: TextStyle(
                          color: Colors.white70,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Colors.white, // Đổi màu underline thành trắng
                          decorationThickness: 1.5, // Độ dày underline
                          height:
                              1.5, // Điều chỉnh khoảng cách giữa underline và chữ
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Free Research Preview",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget promptContainer(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.5),
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        "Text",
        style: const TextStyle(
          color: Colors.white, // Màu chữ trắng
          fontSize: 16, // Kích thước chữ
        ),
      ),
    );
  }
}
