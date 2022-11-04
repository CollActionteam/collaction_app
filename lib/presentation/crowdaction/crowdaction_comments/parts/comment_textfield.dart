part of '../crowdaction_comments_page.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TextFormField(
        decoration: InputDecoration(
          border: _border,
          focusedBorder: _border,
          enabledBorder: _border,
          errorBorder: _border,
          hintText: 'Write a comment',
          hintStyle: body,
          suffixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              CollactionIcons.arrow_up_circled,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}

final _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20),
  gapPadding: 0,
  borderSide: BorderSide.none,
);
