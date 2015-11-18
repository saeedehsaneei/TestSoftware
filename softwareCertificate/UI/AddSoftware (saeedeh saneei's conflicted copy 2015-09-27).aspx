<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Main.Master" AutoEventWireup="true" CodeBehind="AddSoftware.aspx.cs" Inherits="softwareCertificate.UI.AddSoftware" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            var code = 0;
            $('#btnSave1').click(function () {
                code = 1;
                alert('اطلاعات با موفقیت ثبت شد');
            });
            $('#btnSave').click(function () {
                createReq();
            });
            FillCmbVahedAddSoftware();
            FillCmbZoneAddSoftware();
            FillCmbLanguageAddSoftware();
            FillCmbMemariAddSoftware();
            FillCmbDbAddSoftware();
            function FillCmbVahedAddSoftware() {
                $('#ddVahed').empty();
                $('#ddVahed2').empty();
                $('#ddVahed').append(' <option value="0">همه واحد ها</option>');
                $('#ddVahed2').append(' <option value="0">انتخاب کنید</option>');

                try {
                    $.ajax({
                        type: "POST",
                        url: "AddSoftware.aspx/FillCmbVahedAddSoftware",
                        data: "{}",//read only az db
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                            $('<option value="' + c.vahedCode + '">' + c.vahedName + '</option>').appendTo("#ddVahed");
                            $('<option value="' + c.vahedCode + '">' + c.vahedName + '</option>').appendTo("#ddVahed2");
                            });

                           
                        },
                        failure: function (response) {
                            alert("اشکال در خواندن اطلاعات");
                        }
                    })
                }

                catch (e) {
                    alert("اشکال در خواندن اطلاعات");
                }
            }
            function FillCmbZoneAddSoftware() {
                $('#ddZone').empty();
                $('#ddZone').append(' <option value="0">انتخاب کنید</option>');

                try {
                    $.ajax({
                        type: "POST",
                        url: "AddSoftware.aspx/FillCmbZoneAddSoftware",
                        data: "{}",//read only az db
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                $('<option value="' + c.zoneCode + '">' + c.zoneName + '</option>').appendTo("#ddZone");

                            });


                        },
                        failure: function (response) {
                            alert("اشکال در خواندن اطلاعات");
                        }
                    })
                }

                catch (e) {
                    alert("اشکال در خواندن اطلاعات");
                }
            }
            function FillCmbLanguageAddSoftware() {
                
                $('#ddLanguage').empty();
                $('#ddLanguage').append(' <option value="0">انتخاب کنید</option>');
                try {
                    $.ajax({
                        type: "POST",
                        url: "AddSoftware.aspx/FillCmbLanguageAddSoftware",
                        data: "{}",//read only az db
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                $('<option value="' + c.programLangCode + '">' + c.languageName + '</option>').appendTo("#ddLanguage");

                            });


                        },
                        failure: function (response) {
                            alert("اشکال در خواندن اطلاعات");
                        }
                    })
                }

                catch (e) {
                    alert("اشکال در خواندن اطلاعات");
                }
            }
            function FillCmbMemariAddSoftware() {
                $('#ddmemari').empty();
                $('#ddmemari').append(' <option value="0">انتخاب کنید</option>');
                try {
                    $.ajax({
                        type: "POST",
                        url: "AddSoftware.aspx/FillCmbMemariAddSoftware",
                        data: "{}",//read only az db
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                $('<option value="' + c.memariCode + '">' + c.memariName + '</option>').appendTo("#ddmemari");

                            });


                        },
                        failure: function (response) {
                            alert("اشکال در خواندن اطلاعات");
                        }
                    })
                }

                catch (e) {
                    alert("اشکال در خواندن اطلاعات");
                }
            }
            function FillCmbDbAddSoftware()
            {
                $('#ddDb').empty();
                $('#ddDb').append(' <option value="0">انتخاب کنید</option>');
                try {
                    $.ajax({
                        type: "POST",
                        url: "AddSoftware.aspx/FillCmbDbAddSoftware",
                        data: "{}",//read only az db
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                $('<option value="' + c.dbCode + '">' + c.name + '</option>').appendTo("#ddDb");

                            });


                        },
                        failure: function (response) {
                            alert("اشکال در خواندن اطلاعات");
                        }
                    })
                }

                catch (e) {
                    alert("اشکال در خواندن اطلاعات");
                }
            }
            function createReq() {
                var request = {};
                if ($('#PatchUpdate').prop("checked") == true) {
                    request.isPatchUpdate = "1";

                }
                else {
                    request.isPatchUpdate = "0";
                }
                if ($('#FtpUpdate').prop("checked") == true) {
                    request.isFtpUpdate = "1";
                }
                else {
                    request.isFtpUpdate = "0";
                }
                if ($('#DirectAccessUpdate').prop("checked") == true) {
                    request.isDirectAccessUpdate = "1";
                }
                else {
                    request.isDirectAccessUpdate = "0";
                }
                if ($('#Other').prop("checked") == true) {
                    request.isOtherUpdate = "1";
                }
                else {
                    request.isOtherUpdate = "0";
                }
                if ($('#ddVahed').find('option:selected').val() == 0) {
                    request.isAllVahed = "1";
                }
                else {
                    request.isAllVahed = "0";
                }
                request.languageCode = $('#ddLanguage').find('option:selected').val();
                request.memariCode = $('#ddmemari').find('option:selected').val();
                request.dbCode = $('#ddDb').find('option:selected').val();
                request.cityInUse = $('#ddlCity').find('option:selected').val();
                request.softwareName = $('#Name').val();
                request.serverLocation = $('#ServerLocation').val();
                request.softwarePrice = $('#Price').val();
                request.isSupport = $('#ddSupport').find('option:selected').val();
                request.companyName = $('#Company').val();
                request.companyAddress = $('#Address').val();
                request.subject = $('#subject').val();
                request.endDateSupport = $('#EndDate').val();
                request.supportPrice = $('#SupportPrice').val();
                request.isUsed = $('#ddUse').find('option:selected').val();
                request.instalationDate = $('#InstallDate').val();
                request.contractNumber = $('#BuyNumber').val();
                request.isHardwareLock = $('#ddLock').find('option:selected').val();
                request.isSource = $('#ddSource').find('option:selected').val();
                request.lastDbVersion = $('#Version').val();
                request.supervisorName = $('#Supervisor').val();
                request.companyTell = $('#TelCo').val();
                request.companyNamayandeName = $('#NameN').val();
                request.supervisorTell = $('#Tel1').val();
                request.supportTell = $('#SupportTell').val();
                request.isReportCreate = $('#ddCreatReport').find('option:selected').val();
                request.isFixReport = $('#ddReport').find('option:selected').val();
                request.userCount = $('#UserCount').val();
                request.isDocument = $('#ddDoc').find('option:selected').val();
                request.softwareProblem = $('#Problem').val();
                request.vahedCode = $('#ddVahed').find('option:selected').val();
                request.zoneCode = $('#ddZone').find('option:selected').val();
                request.isOpBuyer = $('#ddBuy').find('option:selected').val();

                var requestUp = {};
                requestUp.upgradeDate = $('#date').val();
                requestUp.vahedCode = $('#ddVahed2').find('option:selected').val();
                requestUp.description = $('#description').val();
                if (code == 0) {
                    try {
                        $.ajax({
                            type: "POST",
                            url: "SoftwareManage.aspx/creatSoftReq",
                            data: JSON.stringify({ rn: request }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                alert("2");
                                var result = $.parseJSON(response.d);
                                if (result.IsSuccessfull) {
                                    $('#lblMessage').text('ثبت اطلاعات با موفقیت انجام شد');
                                    SoftwareReq(0);
                                   
                                }
                                else {
                                    alert(result.Message);
                                }
                            },
                            failure: function (response) {
                                alert("error");
                                $('#lblMessage').text('ارتباط با سرور برقرار نشد-خطای شماره 3');
                            }
                        })
                    }
                    catch (e) {
                        alert("اشکال در خواندن اطلاعات");
                    }
                }
                else {

                    try {
                        $.ajax({
                            type: "POST",
                            url: "SoftwareManage.aspx/creatSoftUpgradeReq",
                            data: JSON.stringify({ rn: request, up: requestUp }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                var result = $.parseJSON(response.d);
                                if (result.IsSuccessfull) {
                                    $('#lblMessage').text('ثبت اطلاعات با موفقیت انجام شد');
                                    SoftwareReq(0);
                                }
                                else {
                                    alert(result.Message);
                                }
                            },
                            failure: function (response) {
                                alert("error");
                                $('#lblMessage').text('ارتباط با سرور برقرار نشد-خطای شماره 3');
                            }
                        })
                    }


                    catch (e) {
                        alert("اشکال در خواندن اطلاعات");
                    }
                }



            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-title"><span>اطلاعات نرم افزار ها</span></div>
        <div class="panel-body">
              <div class="row">
                <div class="col-md-4">
                    <div class="form-group col-md-12">
                        <div class="input-group row-fluid">
                            <span class="input-group-addon">نام شهر</span>
                            <select class="selectpicker" id="ddlCity" data-width="75%" >
                                <option>کرمان</option>
                             
                            </select>
                        </div>
                    </div>
                      <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">نام  نرم افزار</span>
                            <input type="text" id="Name" class="form-control"  aria-describedby="basic-addon1" />
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">موضوع کاربرد نرم افزار</span>
                            <input type="text" id="subject" class="form-control"aria-describedby="basic-addon1" />
                        </div>
                    </div>
                      <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">نام شرکت طرف قرارداد</span>
                            <input type="text" id="Company" class="form-control"  aria-describedby="basic-addon1" />
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">نام نماینده شرکت</span>
                            <input type="text" id="NameN" class="form-control"  aria-describedby="basic-addon1" />
                        </div>
                    </div>
                      <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">مبلغ خرید(ریال)</span>
                            <input type="text" id="Price" class="form-control"  aria-describedby="basic-addon1" />
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">تاریخ نصب نرم افزار</span>
                            <input type="text" id="InstallDate" class="form-control"  aria-describedby="basic-addon1" />
                        </div>
                    </div>

                </div>
                <!--Column 2-->
                <div class="col-md-4">
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">نام واحد</span>
                            <select  data-width="75%" id="ddVahed" class="form-control">
                              <option value="0">تمام واحد ها</option> 
                             
                            </select>
                        </div>
                    </div>
                      <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">زبان برنامه نویسی</span>
                            <select  data-width="75%" id="ddLanguage" class="form-control">
                            </select>       

                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">نوع پایگاه داده</span>
                            <select  data-width="75%" id="ddDb" class="form-control">
                            </select>  
                             </div>
                    </div>
                      <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">  شماره تماس شرکت</span>
                            <input type="text" class="form-control" id="TelCo"/>
                            
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">نام سوپروایزر اصلی</span>
                            <input type="text" class="form-control" id="Supervisor"  />
                        </div>
                    </div>
                      <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">مبلغ قرارداد پشتیبانی(ریال)</span>
                            <input type="text" id="SupportPrice" class="form-control"  />
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">تاریخ اتمام پشتیبانی</span>
                            <input type="text" id="EndDate" class="form-control"  />
                        </div>
                    </div>
                </div>
                 <!--***** Column 3 *****--> 
                <div class="col-md-4">
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">حوزه نرم افزار</span>
                            <select  data-width="75%" id="ddZone" class="form-control">
                            </select>
                        </div>
                    </div>
                      <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">معماری سیستم</span>
                            <select  data-width="75%" id="ddmemari" class="form-control" >
                            </select>       

                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">آخرین نسخه</span>
                            <input type="text" class="form-control" id="Version"/>
 
                             </div>
                    </div>
                      <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">آدرس</span>
                            <input type="text" class="form-control" id="Address" />
                            
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">شماره تماس</span>
                            <input type="text" id="Tel1" class="form-control"  />
                        </div>
                    </div>
                     <div class="form-group col-md-12"><hr /></div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon">شماره قرارداد خرید</span>
                            <input type="text" class="form-control" id="BuyNumber" />
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="input-group">
                            <span class="input-group-addon"> شماره تماس پشتیبانی</span>
                            <input type="text" class="form-control" id="SupportTell"  />
                        </div>
                    </div>
            </div>
          </div>
              <div class="form-group col-md-12"><hr /></div>
                <div class="row">
                <div class="col-md-4">
                    <div class="form-group col-md-12">
                    <div class="input-group">
                       <span class="input-group-addon">قرارداد پشتیبانی</span>
                            <select  data-width="75%" id="ddSupport10" class="form-control" >
                                 <option value='0'>ندارد</option>
                                <option value='1'>دارد</option>
                            </select>    
                    </div>
               </div>
                    <div class="form-group col-md-12">
                    <div class="input-group">
                       <span class="input-group-addon">از نرم افزار استفاده میشود</span>
                            <select  data-width="75%" id="ddUse10" class="form-control">
                                 <option value ="0">خیر</option>
                                 <option value="1">بلی</option>
                            </select>   
                    </div>
               </div>
                    <div class="form-group col-md-12">
                    <div class="input-group">
                       <span class="input-group-addon">قفل سخت افزاری</span>
                            <select  data-width="75%" id="ddLock10" class="form-control">
                                 <option value="0">ندارد</option>
                                 <option value="1">دارد</option>
                            </select>    
                    </div>
               </div>
                    <div class="form-group  col-md-12">
                    <div class="input-group">
                       <span class="input-group-addon">sourc نرم افزار موجود است</span>
                            <select  data-width="75%" id="ddSource10" class="form-control">
                                 <option value ="0">خیر</option>
                                 <option value="1">بلی</option>
                               
                            </select>    
                    </div>
               </div>
                </div>
                <div class="col-md-4">
                   <div class="form-group col-md-12">
                    <div class="input-group ">
                       <span class="input-group-addon">نوع گزارشگیری از سیستم</span>
                            <select data-width="75%" id="ddReport10" class="form-control">
                                <option value="0">ثابت</option>
                                <option value="1">پویا</option>
                            </select>    
                    </div>
               </div>
                   <div class="form-group col-md-12">
                    <div class="input-group">
                       <span class="input-group-addon">سیستم مجهز به گزارش ساز میباشد</span>
                            <select  data-width="75%" id="ddCreatReport10" class="form-control">
                                 <option value ="0">خیر</option>
                                 <option value="1">بلی</option>
                            </select>    
                    </div>
               </div>                            
                   <div class="form-group col-md-12">
                    <div class="input-group ">
                       <span class="input-group-addon">وجود مستندات راهنمای کاربری نرم افزار</span>
                            <select data-width="75%" id="ddDoc10" class="form-control">
                                <option value="0">ندارد</option>
                                <option value="1">دارد</option>
                            </select>    
                    </div>
               </div>
                   <div class="form-group col-md-12">
                    <div class="input-group ">
                       <span class="input-group-addon">خریدار</span>
                        <select  data-width="75%" id="ddBuy10"  class="form-control">
                            <option value="0">وزارت خانه</option>
                            <option value="1">علوم پزشکی</option>
                        </select>    
                    </div>
               </div>
                </div>
                <div class="col-md-4">
                 <div class="form-group col-md-12">
                     <div class="input-group">
                         <span class="input-group-addon">تعداد کاربران مجاز</span>
                         <input type="text" class="form-control"id="UserCount" />
                     </div>
                 </div>
                 <div class="form-group col-md-12">
                      <div class="input-group">
                           <span class="input-group-addon">محل قرار گرفتن سرور نرم افزار</span>
                            <input type="text" class="form-control" id="ServerLocation"/>
                         
                          </div>
                     </div>
                 <div class="form-group col-md-12">
                      <div class="input-group">
                                     <span class="input-group-addon">نحوه به روز رسانی</span>
                                    <input type="text" class="form-control" id="Update" />
                               </div>
                     </div>
                </div>
             </div>
                <div class="row">
                  <div class="col-md-12 alert-info" style="padding: 15px;">
                  <div class="form-group">
                        <label class="label" style="font:bold 14px WYekan;color:#0094ff;"> نحوه بروز رسانی : </label>
                    <%--  <hr />--%>
                    <div class="checkbox-inline">
                        <label>
                            <input type="checkbox" value="" id="PatchUpdate1" />PatchUpdate</label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="checkbox" value="" id="FtpUpdate1" />FtpUpdate</label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="checkbox" value="" id="DirectAccessUpdate1" />DirectAccessUpdate</label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="checkbox" value="" id="test1" />سایر</label>
                    </div>
                                           
                </div>
            </div>
        </div>                 
             <div class="col-md-12"><hr /></div>
                <div class="row">
                   <div class="col-md-12">
                          <div class="form-group">
                             <span class="label" style="color:#000; font:bold 14px WYekan;">مشکلات موجود در نرم افزار</span>
                              </div>
                          <div class="form-group">
                                    <textarea  class="form-control" id="Problem" ></textarea>
                          </div>
                      </div>
                </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group pull-left">
                        <span id="lblMessage"></span>
                         <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal1"  data-target=".bs-example-modal-lg"><i class="fa fa-plus"></i>&nbsp;اطلاعات مربوط به ارتقاء</button>
                        <button type="button" id="btnSave" class="btn btn-success">ذخیره اطلاعات</button>
                       <button type="button" class="btn btn-default" data-dismiss="modal">انصراف</button>

                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
            
    </div>
     <div class="modal fade bs-example-modal-lg" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="gridSystemModalLabel1">اطلاعات مربوط به ارتقاء</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon">نام واحد درخواست کننده</span>
                                                 <select  data-width="75%" id="ddVahed2" class="form-control" >
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon">تاریخ ارتقاء سیستم</span>
                                                <input type="text" class="form-control" id="date"  aria-describedby="basic-addon1" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon">توضیحات</span>
                                                <input type="text" class="form-control" id="description"  aria-describedby="basic-addon1" />
                                            </div>
                                        </div>
                                       
                                        
                                         
                                        
                                       
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    
                    <button type="button" class="btn btn-default" data-dismiss="modal">انصراف</button>
                    <button type="button" id="btnSave1" class="btn btn-success">ذخیره اطلاعات</button>
                    

                </div>
            </div>
        </div>
    </div>

</asp:Content>
