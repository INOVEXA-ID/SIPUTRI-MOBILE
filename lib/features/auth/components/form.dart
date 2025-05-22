import 'package:flutter/material.dart';
import 'package:siputri_mobile/core/config/app_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset('assets/images/logo_fix.png', width: 120, height: 120),
            Text(
              "SIPUTRI",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              "SISTEM PERPUSTAKAAN ELEKTRONIK",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
            ),
            Text(
              "POLITEKNIK NEGERI JEMBER",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
            ),
            SizedBox(height: 20),
            TextFormField(
              // onChanged:
              //     (value) => context.read<LoginBloc>().add(
              //       LoginEmailChanged(value),
              //     ),
              validator:
                  (value) => value!.isEmpty ? 'Email tidak boleh kosong' : null,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              // onChanged:
              //     (value) => context.read<LoginBloc>().add(
              //       LoginPasswordChanged(value),
              //     ),
              validator:
                  (value) =>
                      value!.isEmpty ? 'Password tidak boleh kosong' : null,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRouter.navigationBarPage,
                  );
                  // if (_formKey.currentState!.validate()) {
                  //   context.read<LoginBloc>().add(LoginSubmitted());
                  // }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Colors.blue[600],
                  elevation: 4,
                ),
                child:
                // state.isSubmitting
                //     ? SizedBox(
                //       width: 24,
                //       height: 24,
                //       child: CircularProgressIndicator(
                //         strokeWidth: 2,
                //         color: Colors.white,
                //       ),
                //     )
                //     :
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            // if (state.isFailure)
            //   Text('Login gagallll', style: TextStyle(color: Colors.red)),
            // if (state.isSuccess)
            //   Text('Login berhasil', style: TextStyle(color: Colors.green)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Belum punya akun? '),
                GestureDetector(
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        AppRouter.registerScreen,
                      ),
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 250),
            Text(
              "Oleh:",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_polije_biru.png',
                  width: 75,
                  height: 75,
                ),
                Image.asset(
                  "assets/images/logo_polije_sip.png",
                  width: 75,
                  height: 75,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
