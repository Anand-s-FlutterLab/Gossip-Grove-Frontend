RegExp passwordValidator = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$&%^()_\-{}\[\];:"<>,.?/*~]).{8,}$');

RegExp emailValidator = RegExp(r'^([a-z0-9._%+-]+)@([a-zA-Z.-]+)\.(com)$');

RegExp phoneValidator = RegExp(r'^\d{10}$');
