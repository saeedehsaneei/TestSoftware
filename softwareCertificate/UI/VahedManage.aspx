<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Main.Master" AutoEventWireup="true" CodeBehind="VahedManage.aspx.cs" Inherits="softwareCertificate.UI.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<%--     <script type="text/javascript" src="../Content/js/jquery-1.11.3.min.js"></script>
     <script type="text/javascript" src="../Content/js/jquery-ui-1.10.3.custom.min.js"></script>--%>
    <style>
        #VahedManage .modal-dialog {
            width: 25%;
        }
    </style>
    <%---------------------------------------------------------------------Function-------------------------------------------------------------------------------------%>
    <script type="text/javascript">
        function readReferencesCountForSearch() {
            return $(document).data("countTotal");
        }
        function fillModal(id) {
            $("#VahedManage").modal("show");
            var vahedCode = id;

            $.ajax({
                type: "POST",
                url: "VahedManage.aspx/VahedReqSeByID",
                data: JSON.stringify({ vahedCode: vahedCode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    try {

                        if (response.d == null) {
                            alert("جوابی یافت نشد");
                        }
                        else {
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                $('#txtVahedName').val(c.vahedName);
                                $('#txtVahedCity').val(c.city);

                            });
                        }
                    }
                    catch (err) {
                    }
                },
                error: function (response) {
                    alert('اشکال در خواندن اطلاعات');
                }
            });
        }

        function createReq() {
            var request = {};

            request.vahedName = $('#txtVahedName').val();
            request.city = $('#txtVahedCity').val();
            try {
                $.ajax({
                    type: "POST",
                    url: "VahedManage.aspx/creatReqVahed",
                    data: JSON.stringify({ rn: request }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var result = $.parseJSON(response.d);
                        if (result.IsSuccessfull) {
                            alert("ثبت اطلاعات با موفقیت انجام شد");
                            loadGrid('TblVahed', readReferencesCountForSearch, VahedReq);

                        }
                        else {
                            alert(result.Message);
                        }
                    },
                    failure: function (response) {
                        $('#lblMessage').text('ارتباط با سرور برقرار نشد-خطای شماره 3');
                    }
                })
            }

            catch (e) {
                alert("اشکال در خواندن اطلاعات");

            }
        }

        function emptyElements(container) {
            var strContainer = '#' + container;
            $('input[type=text]', strContainer).each(function (element) {
                $(this).val('');
            });
            $('select', strContainer).each(function (element) {
                $(this).find('option:selected').val("0");
            });
        }

        function VahedReq(firstRow) {
            $(document).data('countTotal', '0');
            $('#TblVahed').empty();
            $.ajax({
                type: "POST",
                url: "VahedManage.aspx/VahedReqSe",
                data: JSON.stringify({ firstRow: firstRow }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async:false,
                success: function (response) {
                    try {

                        if (response.d == null) {
                            $('#TblVahed').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
                        }
                        else {
                            var count = 0;
                            var color;
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                count += 1;
                                if (count % 2 == 0) {
                                    color = '#eaf6fd ';
                                }
                                else {
                                    color = ' #f2f2f2';
                                }
                                if (c.cnt == null)
                                $('#TblVahed').append('<tr style="background-color: ' + color + '" id="row_' + c.zoneCode + '"><td id="1col_' + c.vahedCode + '" style="text-align:center;width:5%">' +
                                    c.RowNo + '</td><td id="2col_' + c.vahedCode + '" style="text-align:center">' +
                                    c.vahedName + '</td>' +
                                   '<td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.vahedCode
                                   + '" </i></td>');
                                $(document).data("countTotal", c.cnt);
                            });
                        }
                    }
                    catch (err) {
                    }
                },
                error: function (response) {
                    alert('اشکال در خواندن اطلاعات');
                }
            });
        };

        function SearchInTable(firstRow) {
            $(document).data('countTotal', '0');
            $('#TblVahed').empty();
            var arr = $(document).data('arrData');
            $.ajax({
                type: "POST",
                url: "VahedManage.aspx/SearchInTable",
               // data: JSON.stringify({ Name: Name }),
                data: JSON.stringify({ Name: arr[0], firstRow: firstRow }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async:false,
                success: function (response) {
                    try {

                        if (response.d == null) {
                            $('#TblVahed').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
                        }
                        else {
                            var count = 0;
                            var color;
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                count += 1;
                                if (count % 2 == 0) {
                                    color = '#eaf6fd ';
                                }
                                else {
                                    color = ' #f2f2f2';
                                }
                                if (c.cnt == null)
                                $('#TblVahed').append('<tr style="background-color: ' + color + '" id="row_' + c.vahedCode + '"><td id="1col_' + c.vahedCode + '" style="text-align:center;width:5%">' +
                                     c.RowNo + '</td><td id="2col_' + c.vahedCode + '" style="text-align:center">' +
                                    c.vahedName + '</td>' +
                                   '<td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.vahedCode
                                   + '" </i></td>');
                                $(document).data("countTotal", c.cnt);
                            });
                        }
                    }
                    catch (err) {
                    }
                },
                error: function (response) {
                    alert('اشکال در خواندن اطلاعات');
                }
            });
        };

        function deleteVahed(id) {
            var vahedCode = id;
            $.ajax({
                type: "POST",
                url: "VahedManage.aspx/deleteVahed",
                data: JSON.stringify({ vahedCode: vahedCode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    try {

                        alert("رکورد مورد نظر با موفقیت حذف شد.");
                    }
                    catch (err) {
                    }
                },
                error: function (response) {
                    alert('اشکال در خواندن اطلاعات');
                }
            });
        };

      </script>
    <%----------------------------------------------------------------------DocumentReady------------------------------------------------------------------------------------%>
    <script type="text/javascript">
        $(document).ready(function () {
            checkLenght();
            changeValid();
            bindPager('RequestPager');
            loadGrid('TblVahed', readReferencesCountForSearch, VahedReq);
            $('#txtVahedName').data('lenght', '30');
            $('#txtVahedCity').data('lenght', '15');

            
            var id;

            $('#txtVahed').keydown(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSearchVahed').focus();
                }
            })

            $('#txtVahed').val('');
            $("#modalAdd").click(function () {
                //   if ($("#InsertForm").valid() === true) {
                alert('true');
                // }
            })
            $('#btnSave').click(function () {
                if (valid('VahedManage') == true) {
                    createReq();
                    $("#VahedManage").modal("hide");
                }
            });
            $("#btnAdd").click(function () {
                validBack('VahedManage');
                emptyElements('VahedManage');
            });
            $('#btnSearchVahed').click(function () {
                var Name = $('#txtVahed').val();
                var data = [Name];
                $(document).data('arrData', data);
                loadGrid('TblVahed', readReferencesCountForSearch, SearchInTable);
            });
            $("#TblVahed").on('click', '.delete', function () {
                id = $(this).attr("id").replace("delete", "");
                var e = confirm("آیا مطمئن هستید؟");
                if (e == true) {
                    deleteVahed(id);
                    loadGrid('TblVahed', readReferencesCountForSearch, VahedReq);
                }
            });
          

        });
        //  });
    </script>
<%--------------------------------------------------------------------------------End Script-----------------------------------------------------------------------------%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-title"><span><i class='fa fa-building-o'></i>&nbsp;اطلاعات واحد ها</span>
                <div class="clearfix">
                </div>
        </div>
        <div class="panel-body panel-body-back">
                  <div class="row row-margin">
                 <div class="col-md-4 background col-md-padding">
                    <div class="form-group">
                        <div class="input-group row-fluid">
                            <span class="input-group-addon">نام واحد</span>
                           <input type="text" class="form-control" id="txtVahed" aria-describedby="basic-addon1" />
                            <span class="input-group-btn"><button type="button" id="btnSearchVahed" class="btn btn-success"><i class="fa fa-search"></i></button></span>
                        </div>
                    </div>
                      <div class="form-group">
                      <button type="button" class="btn btn-success" data-toggle="modal" data-target="#VahedManage" id="btnAdd" data-target=".bs-example-modal-lg""><i class="fa fa-plus"></i>&nbsp; واحد جدید</button>
                </div>   
                 </div>
                 <div class="col-md-8 back-right-box col-md-padding">
                 <table id="example" class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th class="head-title">ردیف</th>
                            <th class="head-title"> نام واحد سازمانی</th>
                            <th class="head-title edit-remove">حذف</th>
                        </tr>
                    </thead>
                    <tbody id="TblVahed">
                        <tr>
                        </tr>
                    </tbody>
                </table>
                    <div id="RequestPager" class="form-group">
                        <nav class="pull-right">
                            <ul class="pagination">
                                <li>
                                    <a href="#">
                                    <input id="BtnFirst" name="BtnFirst" type="button" value="اولین" />
                                        <i class="fa fa-fast-forward"></i>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                    <input id="BtnPrevius" name="BtnPrevius" type="button" value="قبلی" />
                                         <i class="fa fa-forward"></i>
                                        </a>
                                </li>
                               <li>
                                    <a href="#">
                                    <input style="width:70px; text-align:center" id="TxtPager" name="TxtPager" type="text" readonly="readonly" />
                                     </a>
                                </li>
                                <li>
                                    <a href="#">
                                    <input id="BtnNext" name="BtnNext" type="button" value="بعدی" />
                                         <i class="fa fa-backward"></i>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                    <input id="BtnLast" name="BtnLast" type="button" value="آخرین" />
                                        <i class="fa fa-fast-backward"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>

                </div>
            </div>      
             </div>  
    </div>
<%---------------------------------------------------------------------------------Modal--------------------------------------------------------------------------------------%>
     <div class="modal fade bs-example-modal-lg" id="VahedManage" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="gridSystemModalLabel"><i class='fa fa-building-o'></i>&nbsp;تعریف واحد سازمانی</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row col-md-padding">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">نام واحد</span>
                                        <input type="text" class="form-control  required lenght" id="txtVahedName" aria-disabled="true" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon" style="vertical-align: top;">نام شهر</span>
                                        <input type="text" id="txtVahedCity" class="form-control  required lenght" aria-disabled="true"  aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                            
                                <div class="form-group col-md-12">
                                    <div class="alert alert-info bs-alert-old-docs hidden">
                                        <label class="label">نتیجه</label>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <span id="lblMessage"></span>
                    <button type="button" id="btnSave" class="btn btn-success">ذخیره اطلاعات</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">انصراف</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
