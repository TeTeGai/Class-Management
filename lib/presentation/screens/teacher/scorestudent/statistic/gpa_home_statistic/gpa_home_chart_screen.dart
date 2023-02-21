
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class GpaHomeChartScreen extends StatefulWidget {
  final StudentModel studentModel;
  const GpaHomeChartScreen({Key? key, required this.studentModel}) : super(key: key);

  @override
  State<GpaHomeChartScreen> createState() => _GpaHomeChartScreenState();
}

class _GpaHomeChartScreenState extends State<GpaHomeChartScreen> {
  late TooltipBehavior _tooltipBehavior;


  Future<int> getGoodGpa() async {
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    var respectsQuery =     FirebaseFirestore.instance
        .collection("class").doc(classId).collection("gpaHomeList").where("idStudent",isEqualTo: widget.studentModel.id).where("category",isEqualTo: "GoodGPA");
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.docs.length;
    return totalEquals;
  }
  Future<int> getBadGpa() async {
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    var respectsQuery =  FirebaseFirestore.instance
        .collection("class").doc(classId).collection("gpaHomeList").where("idStudent",isEqualTo: widget.studentModel.id).where("category",isEqualTo: "BadGPA");
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.docs.length;
    return totalEquals;
  }
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: Future.wait([
              getGoodGpa(),
              getBadGpa(),
            ]),
            builder: (context, AsyncSnapshot<List> snapshot)
            {
              switch(snapshot.connectionState)
              {
                case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                             return snapshot.data![0] >0|| snapshot.data![1]>0 ?Center(
                                 child: Container(
                                     child: SfCircularChart(
                                       // Enables the legend
                                         legend: Legend(isVisible: true),
                                         tooltipBehavior: _tooltipBehavior,
                                         series: <CircularSeries<GpaData, String>>[
                                           // Initialize line series
                                           PieSeries<GpaData, String>(
                                               dataSource: [
                                                 // Bind data source
                                                 GpaData('Tích cực', int.parse(snapshot.data![0].toString())),
                                                 GpaData('Cần cải thiện', int.parse(snapshot.data![1].toString())),
                                               ],
                                               xValueMapper: (GpaData sales, _) => sales.category,
                                               yValueMapper: (GpaData sales, _) => sales.count,
                                               name: 'Điểm rèn luyện',

                                               dataLabelSettings: DataLabelSettings(isVisible: true))
                                         ]))):Center();


                          }
                        }

        ),

      ],
    );
  }

}

class GpaData {
  GpaData(this.category, this.count);

  final String category;
  final int count;
}



