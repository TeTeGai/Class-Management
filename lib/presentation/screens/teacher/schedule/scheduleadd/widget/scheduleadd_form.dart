import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/schedule_model.dart';
import 'package:luan_an/presentation/common_blocs/schedule/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/schedule/scheduleadd/widget/schedule_input.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/snackbar.dart';

class ScheduleAddForm extends StatefulWidget {
   final ScheduleModel? scheduleModel;
   const ScheduleAddForm({Key? key, this.scheduleModel}) : super(key: key);

  @override
  State<ScheduleAddForm> createState() => _ScheduleAddFormState();
}

class _ScheduleAddFormState extends State<ScheduleAddForm> {
  get isEditMote => widget.scheduleModel != null;
  late ScheduleBloc scheduleBloc;
  late TextEditingController _titlecontroller;
  late TextEditingController _notecontroller;
  late DateTime currentdate;
  static var _starthour = TimeOfDay.now();

  var endhour = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();
  late int _selectedcolor;
  List<Color> colors = [Colors.blueAccent, Colors.pink, Colors.yellow];
  @override
  void initState() {
    scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
    _titlecontroller =
        TextEditingController(text: isEditMote ? widget.scheduleModel!.title : '');
    _notecontroller =
        TextEditingController(text: isEditMote ? widget.scheduleModel!.note : '');

    currentdate =
    isEditMote ?  DateTime.parse(widget.scheduleModel!.date)  : DateTime.now();

    endhour = TimeOfDay(
      hour: _starthour.hour + 1,
      minute: _starthour.minute,
    );
    _selectedcolor = isEditMote ? widget.scheduleModel!.colorIndex : 0;
    super.initState();
  }

  Future<void> onCreate() async {
    if(_titlecontroller.text.trim().isNotEmpty && _notecontroller.text.trim().isNotEmpty)
      {
        ScheduleModel scheduleModel;
        late ScheduleModel initModel;
        setState(() {
          scheduleModel = ScheduleModel(
            id: "",
            startTime: _starthour.format(context),
            note: _notecontroller.text,
            endTime: endhour.format(context),
            date: DateFormat('yyyy-MM-dd').format(currentdate),
            colorIndex: _selectedcolor,
            title: _titlecontroller.text,
          );
          initModel = scheduleModel.cloneWith();
        });

        try
        {
          scheduleBloc.add(
              ScheduleAdd(initModel,'Đã thêm 1 lịch '+ _titlecontroller.text +" ngày "+DateFormat('dd/MM/yyyy').format(currentdate))
          );
          Navigator.of(context).pop();
          MySnackBar.error(message: "Tạo lịch thành công", color: Colors.cyan, context: context);
        }
        catch(e)
        {
          MySnackBar.error(message: "Có lỗi gì đó đã xảy ra vui lòng thử lại", color: Colors.red, context: context);
        }

      }
    else{
      MySnackBar.error(message: "Chưa nhập đủ nội dung", color: Colors.red, context: context);
    }
  }

  Future<void> onUpdate() async {
    try{
      scheduleBloc.add(
          ScheduleUpdateModel(
              widget.scheduleModel!.id,
              _titlecontroller.text,
              _notecontroller.text,
              DateFormat('yyyy-MM-dd').format(currentdate),
              _starthour.format(context),
              endhour.format(context),
              _selectedcolor)
      );
      Navigator.of(context).pop();
      MySnackBar.error(message: "Cập nhật lịch thành công", color: Colors.cyan, context: context);
    }
    catch(e)
    {
      MySnackBar.error(message: "Có gì đó sai sai", color: Colors.red, context: context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ScheduleBloc(),
        child: BlocListener<ScheduleBloc,ScheduleState>(
          listener: (context, state) {

          },
          child: BlocBuilder<ScheduleBloc,ScheduleState>(
            builder: (context, state) {
              return  Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(color: Colors.black),
                  title:  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Text('Thêm mới lịch',  maxLines: 4,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
                  ),
                  centerTitle: true,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.close,
                        size: 24,
                      ),
                      padding: EdgeInsets.only(left: 0),
                      shape: CircleBorder(),
                    ),
                  ),
                ),
                body:  Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            'Chủ đề',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 19.sp),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ScheduleInput(
                            hint: 'Chủ đề',
                            icon: Icons.title,
                            showicon: false,
                            validator: (value) {
                              return value!.isEmpty ? "Xin nhập vào chủ đề" : null;
                            },
                            textEditingController: _titlecontroller,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            'Mô tả',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 19.sp),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ScheduleInput(
                            hint: 'Mô tả',
                            icon: Icons.ac_unit,
                            showicon: false,
                            maxlenght: 40,
                            validator: (value) {
                              return value!.isEmpty ? "Xin nhập vào mô tả" : null;
                            },
                            textEditingController: _notecontroller,
                          ),
                          Text(
                            'Ngày',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 19.sp),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ScheduleInput(
                            hint: DateFormat('dd/MM/yyyy').format(currentdate),
                            icon: Icons.calendar_today,
                            readonly: true,
                            showicon: false,
                            validator: (value) {},
                            ontap: () async {
                              var selecteddate = await showDatePicker(
                                context: context,
                                locale:  Locale("vi",'VN'),
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2200),
                                currentDate: DateTime.now(),
                              );
                              setState(() {
                                selecteddate != null ? currentdate =  selecteddate : DateTime.now();
                              });
                            },
                            textEditingController: TextEditingController(),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Giờ bắt đầu',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 19.sp),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    ScheduleInput(
                                      hint: DateFormat('HH:mm a').format(DateTime(
                                          0, 0, 0, _starthour.hour, _starthour.minute)),
                                      icon: Icons.watch_outlined,
                                      showicon: false,
                                      readonly: true,
                                      validator: (value) {},
                                      ontap: () {
                                        Navigator.push(
                                            context,
                                            showPicker(
                                              value: _starthour,
                                              is24HrFormat: true,
                                              accentColor: Colors.deepPurple,
                                              onChange: (TimeOfDay newvalue) {
                                                setState(() {
                                                  _starthour = newvalue;
                                                  endhour = TimeOfDay(
                                                    hour: _starthour.hour < 22
                                                        ? _starthour.hour + 1
                                                        : _starthour.hour,
                                                    minute: _starthour.minute,
                                                  );
                                                });
                                              },
                                            ));
                                      },
                                      textEditingController: TextEditingController(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Giờ kết thúc',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 19.sp),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    ScheduleInput(
                                      hint: DateFormat('HH:mm a').format(
                                          DateTime(0, 0, 0, endhour.hour, endhour.minute)),
                                      icon: Icons.watch,
                                      showicon: false,
                                      readonly: true,
                                      validator: (value) {},
                                      ontap: () {
                                        Navigator.push(
                                            context,
                                            showPicker(
                                              value: endhour,
                                              is24HrFormat: true,
                                              minHour: _starthour.hour.toDouble() - 1,
                                              accentColor: Colors.deepPurple,
                                              onChange: (TimeOfDay newvalue) {
                                                setState(() {
                                                  endhour = newvalue;
                                                });
                                              },
                                            ));
                                      },
                                      textEditingController: TextEditingController(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Màu sắc',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 19.sp),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                children: List<Widget>.generate(
                                    3,
                                        (index) => Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedcolor = index;
                                          });
                                        },
                                        child: CircleAvatar(
                                            backgroundColor: colors[index],
                                            child: _selectedcolor == index
                                                ? const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )
                                                : null),
                                      ),
                                    )),
                              ),
                              Container(
                                width: 40.w,
                                padding: EdgeInsets.symmetric(vertical: 0.1.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: isEditMote ? Colors.green : Colors.deepPurple,
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    isEditMote? onUpdate():onCreate() ;
                                  },
                                  child: Text(
                                    isEditMote ? "Cập nhật lịch" : 'Thêm mới lịch',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 18.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },

          ),
        )

    );

  }
}
