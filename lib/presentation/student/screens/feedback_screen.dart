import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  final String vendorId;
  const FeedbackScreen({super.key, required this.vendorId});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 3.0;
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Vendor ID: ${widget.vendorId}'),
            const SizedBox(height: 20),
            const Text('Rating', style: TextStyle(fontSize: 18)),
            Slider(
              value: _rating,
              min: 1,
              max: 5,
              divisions: 4,
              label: _rating.toString(),
              onChanged: (double value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Feedback (Optional)',
              ),
              maxLines: 4,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // In a real app, you would dispatch an event to a FeedbackBloc
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Thank you for your feedback!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
