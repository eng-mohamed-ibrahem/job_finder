import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with RouteAware {
  RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    // assign the route to the active route
  }
  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    // assign the route to the active route
  }

  getData() async {
    await Dio()
        .postUri(
      Uri.parse(
          'http://167.71.79.133/api/auth/register?email=mohamed42343@gmail.com&name=mohamed1232&password=43243mlkm423'),
    )
        .then((response) {
      debugPrint(response.data['data'].toString());
    });
  }

  @override
  void dispose() {
    // [routeAware] is no longer informed about changes to its route.
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return const Scaffold(
      body: Center(
        child: Text('Test Widget'),
      ),
    );
  }
}
