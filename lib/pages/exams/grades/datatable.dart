import 'package:flutter/material.dart';

class DataTableWidget extends StatefulWidget {
  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Column 1')),
          DataColumn(label: Text('Column 2')),
          DataColumn(label: Text('Column 3')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('Row 1 Col 1')),
            DataCell(Text('Row 1 Col 2')),
            DataCell(Text('Row 1 Col 3')),
          ]),
          DataRow(cells: [
            DataCell(Text('Row 2 Col 1')),
            DataCell(Text('Row 2 Col 2')),
            DataCell(Text('Row 2 Col 3')),
          ]),
        ],
      ),
    );
  }
}
