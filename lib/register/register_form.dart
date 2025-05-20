import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'NIM',
                  prefixIcon: Icon(Icons.portrait_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                keyboardType: TextInputType.text,
                onChanged:
                    (value) =>
                        context.read<RegisterBloc>().add(NimChanged(value)),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                keyboardType: TextInputType.text,
                onChanged:
                    (value) =>
                        context.read<RegisterBloc>().add(NamaChanged(value)),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Laki-laki',
                    child: Text('Laki-laki'),
                  ),
                  DropdownMenuItem(
                    value: 'Perempuan',
                    child: Text('Perempuan'),
                  ),
                ],
                onChanged:
                    (value) => context.read<RegisterBloc>().add(
                      JenisKelaminChanged(value!),
                    ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                keyboardType: TextInputType.phone,
                onChanged:
                    (value) =>
                        context.read<RegisterBloc>().add(TeleponChanged(value)),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged:
                    (value) =>
                        context.read<RegisterBloc>().add(AlamatChanged(value)),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged:
                    (value) =>
                        context.read<RegisterBloc>().add(EmailChanged(value)),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                obscureText: true,
                onChanged:
                    (value) => context.read<RegisterBloc>().add(
                      PasswordChanged(value),
                    ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RegisterBloc>().add(RegisterSubmitted());
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
                      state.isSubmitting
                          ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text(
                            'Daftar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                ),
              ),
              if (state.isSuccess)
                const Text(
                  'Registrasi Berhasil!',
                  style: TextStyle(color: Colors.green),
                ),
              if (state.isFailure)
                const Text(
                  'Registrasi Gagal!',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        );
      },
    );
  }
}
