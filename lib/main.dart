import 'package:flutter/material.dart';

void main() {
  runApp(const BinarioConverterApp());
}

class BinarioConverterApp extends StatelessWidget {
  const BinarioConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertidor a Binario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _decimalController = TextEditingController();
  String _resultadoBinario = '';
  String _mensajeError = '';
  bool _calculando = false;

  String _decimalABinario(int numero) {
    if (numero == 0) return '0';
    
    String binario = '';
    int temp = numero;
    
    while (temp > 0) {
      binario = (temp % 2).toString() + binario;
      temp = temp ~/ 2;
    }
    
    return binario;
  }

  void _convertir() {
    final entrada = _decimalController.text.trim();
    
    if (entrada.isEmpty) {
      setState(() {
        _mensajeError = '⚠️ Ingresa un número decimal';
        _resultadoBinario = '';
      });
      return;
    }
    
    final decimal = int.tryParse(entrada);
    if (decimal == null) {
      setState(() {
        _mensajeError = '❌ Solo se permiten números enteros';
        _resultadoBinario = '';
      });
      return;
    }
    
    if (decimal < 0) {
      setState(() {
        _mensajeError = '❌ Solo números positivos';
        _resultadoBinario = '';
      });
      return;
    }
    
    setState(() {
      _calculando = true;
      _mensajeError = '';
    });
    
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _resultadoBinario = _decimalABinario(decimal);
        _calculando = false;
      });
    });
  }

  void _limpiar() {
    setState(() {
      _decimalController.clear();
      _resultadoBinario = '';
      _mensajeError = '';
      _calculando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          '🔢 Convertidor Decimal a Binario',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.biotech,
                        size: 60,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Convertidor Matemático',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Transforma números decimales a sistema binario',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              TextField(
                controller: _decimalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Número Decimal',
                  hintText: 'Ejemplo: 42, 255, 1024',
                  prefixIcon: const Icon(Icons.edit, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(fontSize: 18),
              ),
              
              const SizedBox(height: 20),
              
              if (_mensajeError.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _mensajeError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 30),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _convertir,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: _calculando
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : const Icon(Icons.calculate, size: 24),
                      label: Text(
                        _calculando ? 'CONVIRTIENDO...' : 'CONVERTIR A BINARIO',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _limpiar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.cleaning_services, size: 24),
                    label: const Text('LIMPIAR'),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              if (_resultadoBinario.isNotEmpty)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.green[50],
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Text(
                          '🎯 RESULTADO',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Decimal:', style: TextStyle(fontSize: 16)),
                            Text(
                              _decimalController.text,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Binario:', style: TextStyle(fontSize: 16)),
                            Text(
                              _resultadoBinario,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}