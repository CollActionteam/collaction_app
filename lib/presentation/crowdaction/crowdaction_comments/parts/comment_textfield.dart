part of '../crowdaction_comments_page.dart';

/// Comment response text field
///
/// [Design](https://www.figma.com/file/dYFW0QF7Fg10dpSIxA3wQb/CollAction-App?node-id=2788%3A18373&t=DLTYxIV5T4DBMHCG-4)
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
