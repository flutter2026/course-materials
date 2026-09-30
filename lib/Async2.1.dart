/*
The async keyword means "the code that calls this function may continue running
before this returns from its own run."

The await operator suspends evaluation of the enclosing async method until the
asynchronous operation represented by its operand completes. When the
asynchronous operation completes, the await operator returns the result of the
operation, if any.

The await operator doesn't block the thread that evaluates the async method.
When the await operator suspends the enclosing async method, the control returns
to the caller of the method.
*/

Future<String> getAFuture() {
  var x = Future<String>.delayed(const Duration(seconds: 5), () => "1");
  return x;
}

Future<String> getAFutureAsync() async {
  var x = await Future<String>.delayed(const Duration(seconds: 5), () => "2");
  return x;
}

main() {
  fA();
  fB();
  fC();
  fD();
  fE();
  fF();
  fG();
}

fA() {
  var x = getAFuture();
  print('fA $x ${DateTime.now()}');
}

fB() async {
  var x = await getAFuture();
  print('fB $x ${DateTime.now()}');
}

fC() {
  var x = Future<String>.delayed(const Duration(seconds: 5), () => "0");
  print('fC $x ${DateTime.now()}');
}

fD() async {
  var x = await Future<String>.delayed(const Duration(seconds: 5), () => "0");
  print('fD $x ${DateTime.now()}');
}

fE() {
  // Async in getAFutureAsync will continue running the calling program during the awaiting. In this case, it continues running fE.
  var x = getAFutureAsync();
  print('fE $x ${DateTime.now()}');
}

fF() async {
  var x = await getAFutureAsync();
  print('fF $x ${DateTime.now()}');
}

fG() async {
  var x = getAFuture();
  print('fG ${await x} ${DateTime.now()}');
}
