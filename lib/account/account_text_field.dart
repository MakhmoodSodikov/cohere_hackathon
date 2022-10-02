import 'package:flutter/material.dart';

class AccountTextField extends StatefulWidget {
  AccountTextField({
    super.key,
    this.onTap,
    this.onChanged,
    required this.enabled,
    this.showCursor,
    this.onButtonTap,
    this.isLoading = false,
  });
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool? enabled;
  final bool? showCursor;
  final Function(String)? onButtonTap;
  final bool isLoading;

  @override
  State<AccountTextField> createState() => _AccountTextFieldState();
}

class _AccountTextFieldState extends State<AccountTextField> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      style: TextStyle(color: Theme.of(context).backgroundColor),
      showCursor: widget.showCursor ?? true,
      cursorColor: Theme.of(context).primaryColor,
      onTap: widget.onTap,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(21, 6, 6, 6),
        suffixIcon: SearchButton(
          onPressed: () {
            print('INSIDE: ${_textEditingController.text}');
            return widget.onButtonTap?.call(
              _textEditingController.value.text,
            );
          },
          isLoading: widget.isLoading,
        ),
        hintText: '@twitter',
        hintStyle: TextStyle(
            color: Theme.of(context).backgroundColor.withOpacity(0.5)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    this.onPressed,
    required this.isLoading,
  });
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        margin: const EdgeInsets.all(
          6,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: isLoading
              ? Container(
                  height: 10,
                  width: 10,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).backgroundColor,
                  ),
                )
              : Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Theme.of(context).backgroundColor,
                ),
        ),
      ),
    );
  }
}
