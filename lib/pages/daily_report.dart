import 'package:WHOFlutter/model/coronamodel.dart';
import 'package:WHOFlutter/model/totalcoronamodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DailyReport extends StatefulWidget {
  @override
  _DailyReportState createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {

  List<CoronaCaseModelClass> dailyReportList = [];

//  List<String> _parameters = ['country', 'cases', 'todayCases', 'deaths','todayDeaths','recovered','active','critical','casesPerOneMillion','deathsPerOneMillion']; // Option 2
//  String _selectedLocation;


  int _sortColumnIndex;
  bool _sortAscending = true;

  var cases;
  var deaths;
  var recovered;
  var active;
  var updatedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cases = 0;
    deaths = 0;
    recovered = 0;
    active = 0;
    updatedTime = "";
    _fetchCoronaTotalDetail();
  }

  void _sort<T>(
      Comparable<T> getField(CoronaCaseModelClass d), int columnIndex, bool ascending) {
    dailyReportList.sort((CoronaCaseModelClass a, CoronaCaseModelClass b) {
      if (!ascending) {
        final CoronaCaseModelClass c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Daily Report\n("+"Updated Time : "+updatedTime+")",textAlign: TextAlign.center,),
              leading: IconButton(
                tooltip: 'Previous choice',
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: futureList()
        )
    );
  }

  Widget futureList() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Card(
                    color: Colors.orange,
                    elevation: 4,
                    child: Center(
                      child: Container(
                        height: 60,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("Cases\n"+cases.toString(),textAlign: TextAlign.center,style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15
                            ),),
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              Expanded(
                child: Card(
                  elevation: 4,
                  color: Colors.red,
                  child: Center(
                    child: Container(
                      height: 60,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("Death\n"+deaths.toString(),textAlign: TextAlign.center,style: TextStyle(
                            fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.deepOrangeAccent,
                  elevation: 4,
                  child: Center(
                    child: Container(
                      height: 60,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("Active\n"+active.toString(),textAlign: TextAlign.center,style: TextStyle(
                              fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Card(
                    color: Colors.green,
                    elevation: 4,
                    child: Center(
                      child: Container(
                        height: 60,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("Recovered\n"+recovered.toString(),textAlign: TextAlign.center,style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),

        Container(
          child: FutureBuilder(
              future: _fetchCoronaData("cases"),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Center(
                        child: Column(
                          children: <Widget>[
                            if (snapshot.error == null) ...[
                              CircularProgressIndicator(),
                            ],
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 40),
                              child: Text(
                                snapshot.error == null
                                    ? "Please Wait ..."
                                    : "No Data Found!!,check your Internet Connection",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(
                        child: dataTableContent()
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }
  Widget dataTableContent() {
    return ListView(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:
          DataTable(
              columns: <DataColumn>[
                DataColumn(label: Text("Country", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 20),),
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                            (CoronaCaseModelClass d) => d.country, columnIndex, ascending)
                ),
                DataColumn(label: Text("TC", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 20),),
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (CoronaCaseModelClass d) => d.cases, columnIndex, ascending)),
                DataColumn(label: Container(
                  height: double.infinity * 0.9,
                  color:  Colors.orange ,
                  width: 70,
                  child: Center(
                    child: Text("NC", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 20),),
                  ),
                ), onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (CoronaCaseModelClass d) => d.todayCases, columnIndex, ascending)),
                DataColumn(label: Text("TD", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 20),),
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (CoronaCaseModelClass d) => d.deaths, columnIndex, ascending)),
                DataColumn(label: Container(
                  height: double.infinity * 0.9,
                  color:  Colors.redAccent ,
                  width: 70,
                  child: Center(
                    child: Text("ND", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 20),),
                  ),
                ), onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (CoronaCaseModelClass d) => d.todayDeaths, columnIndex, ascending)),
                DataColumn(label: Text("TR", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 20),)),
                DataColumn(label: Text("AC", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 20),)),
                DataColumn(label: Text("SC", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 20),)),
                DataColumn(label: Text("CPOM", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 20),)),
                DataColumn(label: Text("DPOM", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 20),))
              ],
              sortColumnIndex: _sortColumnIndex,
              sortAscending: true,
              rows: dailyReportList.map((e) =>
                  DataRow(
                      cells: <DataCell>[
                        DataCell(Container(
                            width: 100,
                            child: Text(e.country)
                        ),
                        ),
                        DataCell(Text(e.cases.toString())),
                        DataCell(Container(
                            height: double.infinity,
                            color: e.todayCases != 0 ? Colors.orange : Colors.transparent,
                            width: 70,
                            child: Center(child: Text(e.todayCases != 0 ? e.todayCases.toString() : "",style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)))
                        )),
                        DataCell(Text(e.deaths.toString())),
                        DataCell(Container(height: double.infinity * 0.9,
                            color: e.todayDeaths != 0 ? Colors.redAccent : Colors.transparent,
                            width: 70,
                            child: Center(child: Text(e.todayDeaths != 0 ? e.todayDeaths.toString() : "",style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15
                            ),))
                        )
                        ),
                        DataCell(Text(e.recovered.toString())),
                        DataCell(Text(e.active.toString())),
                        DataCell(Text(e.critical.toString())),
                        DataCell(Text(e.casesPerOneMillion.toString())),
                        DataCell(Text(e.deathsPerOneMillion.toString())),
                      ]
                  )
              ).toList()
          ),
        ),
      ],
    );
  }

  _fetchCoronaData(parameter) async {
    String dataURL = "https://corona.lmao.ninja/countries?sort=$parameter";
    http.Response response = await http.get(dataURL);
    dailyReportList.clear();
    for (CoronaCaseModelClass datum in coronaCaseModelClassFromJson(
        response.body)) {
      dailyReportList.add(datum);
    }
    return dailyReportList;
  }

  _fetchCoronaTotalDetail() async {
    String dataURL = "https://corona.lmao.ninja/all";
    http.Response response = await http.get(dataURL);

    var totalDetail = coronaTotalCaseModelClassFromJson(response.body);
    setState(() {
      cases = totalDetail.cases;
      deaths = totalDetail.deaths;
      recovered = totalDetail.deaths;
      active = totalDetail.active;
      readTimestamp(totalDetail.updated);
    });

    return dailyReportList;
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    setState(() {
      updatedTime = time;
    });

    return time;
  }
}
