import 'package:flutter/material.dart';

import '../../../../domain/user/i_user_repository.dart';
import '../../../../domain/user/user.dart';
import '../../../../infrastructure/core/injection.dart';
import '../../../shared_widgets/pill_button.dart';
import '../../../themes/constants.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({Key? key}) : super(key: key);

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  String _value = "";

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: StreamBuilder(
            stream: getIt<IUserRepository>().observeUser(),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: snapshot.data?.photoURL != null
                        ? NetworkImage(
                            snapshot.data?.photoURL ?? "",
                          )
                        : null,
                    child: Container(
                      color: Colors.grey[300],
                      child: Text(
                        (snapshot.data?.displayName?.toUpperCase() ?? "A")[0],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data?.displayName ?? "",
                      style: const TextStyle(
                        color: kPrimaryColor400,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Write a comment",
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            fillColor: kAlmostTransparent,
          ),
          minLines: 1,
          maxLines: 5,
          style: const TextStyle(
            color: kPrimaryColor300,
            fontWeight: FontWeight.w300,
          ),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        const SizedBox(
          height: 15,
        ),
        PillButton(
          text: "Publish comment",
          isEnabled: _value.isNotEmpty,
          onTap: () {},
        )
      ],
    );
  }
}
