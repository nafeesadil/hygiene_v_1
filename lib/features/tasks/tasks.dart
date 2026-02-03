import 'package:flutter/material.dart';
import 'package:hygiene_v_1/features/tasks/widgets/task_cards.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 20,
              ),
              child: Row(
                children: [
                  Text(
                    'My ',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text('Tasks', style: TextStyle(fontSize: 28)),
                ],
              ),
            ),

            SizedBox(height: 10),
            // ignore: sized_box_for_whitespace
            Container(
              height: 200,
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: [TaskCard(), TaskCard(), TaskCard()],
              ),
            ),

            SizedBox(height: 25),

            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.grey.shade800,
                dotColor: Colors.grey.shade400,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),

            SizedBox(height: 25),

            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.health_and_safety,
                    color: const Color.fromARGB(255, 144, 151, 144),
                  ),
                  title: Text('Wash hands'),
                ),
                ListTile(
                  leading: Icon(Icons.tap_and_play, color: Colors.green),
                  title: Text('Clean surfaces'),
                ),
                ListTile(
                  leading: Icon(Icons.wash_sharp, color: Colors.grey),
                  title: Text('wash utensils'),
                ),
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Dispose waste'),
                ),
                ListTile(
                  leading: Icon(Icons.cleaning_services, color: Colors.blue),
                  title: Text('Sanitize area'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.report_gmailerrorred,
                    color: Colors.orange,
                  ),
                  title: Text('Report issues'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
