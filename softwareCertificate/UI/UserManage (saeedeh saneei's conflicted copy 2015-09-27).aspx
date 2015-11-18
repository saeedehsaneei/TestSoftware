<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Main.Master" AutoEventWireup="true" CodeBehind="UserManage.aspx.cs" Inherits="softwareCertificate.UI.UserManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #myModal .modal-dialog {
            width: 45%;
        }
    </style>
    <%-------------------------------------------------------------------Function------------------------------------------------------------------------------%>
    <script type="text/javascript">
        function createReq() {
            var request = {};

            request.fName = $('#FName').val();
            request.lName = $('#LName').val();
            request.userName = $('#UserName').val();
            request.pass = $('#Pass').val();
            request.email = $('#Email').val();
            request.mobile = $('#Mobile').val();
            request.zoneCode = $('#ddZone').find('option:selected').val();

            var arrType = new Array();
            var j = 1;
            $.each($('#tblVahed tr'), function (index) {
                var vahedReqType = {};
                vahedReqType.vahedCode = $('#ROW_j' + j + ' td:nth-child(2)').text();
                alert(vahedReqType.vahedCode);

                arrType.push(vahedReqType);
                j++;

            });
            try {
                $.ajax({
                    type: "POST",
                    url: "UserManage.aspx/creatReqUser",
                    data: JSON.stringify({ rn: request, rgr: arrType }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var result = $.parseJSON(response.d);
                        if (result.IsSuccessfull) {
                            $('#lblMessage').text('ثبت اطلاعات با موفقیت انجام شد');
                            UserReq();

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
        };

        function FillCmbZoneAddUser() {
            $('#ddZone').empty();
            $('#ddZone').append(' <option value="">انتخاب کنید</option>');
            try {
                $.ajax({
                    type: "POST",
                    url: "UserManage.aspx/FillCmbZoneAddUser",
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
        };

        function FillCmbVahedAddUser() {
            $('#ddVahed').empty();
            $('#ddVahed').append(' <option value="0">انتخاب کنید</option>');
            try {
                $.ajax({
                    type: "POST",
                    url: "UserManage.aspx/FillCmbVahedAddUser",
                    data: "{}",//read only az db
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var result = $.parseJSON(response.d);
                        $.each(result.Value, function (index, c) {
                            $('<option value="' + c.vahedCode + '">' + c.vahedName + '</option>').appendTo("#ddVahed");

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
        };

        function UserReq() {

            $('#TblUser').empty();
            $.ajax({
                type: "POST",
                url: "UserManage.aspx/UserReqSe",
                data: {},
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    try {

                        if (response.d == null) {
                            $('#TblUser').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
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
                                $('#TblUser').append('<tr style="background-color: ' + color + '" id="row_' + c.userCode + '"><td id="1col_' + c.userCode + '" style="text-align:center">' +
                                    c.userCode + '</td><td id="2col_' + c.userCode + '" style="text-align:center">' +
                                    c.Name + '</td><td id="3col_' + c.userCod + '" style="text-align:center">' +
                                    c.userName + '</td>' +
                                  '<td id="2col_' + c.userCode + '" style="text-align:center">' +
                                    c.mobile + '</td><td id="2col_' + c.userCode + '" style="text-align:center">' +
                                    c.email + '</td>' +
                                  '<td class="edit-remove"><i class="edite fa fa-edit " style="cursor: pointer" id="edit' + c.userCode
                                   + '" </i></td><td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.userCode
                                    + '" </i></td>');
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

        function VahedUserReq(id) {
            $('#tblVahed').empty();
            var userCode = id
            $.ajax({
                type: "POST",
                url: "UserManage.aspx/VahedUserReq",
                data: JSON.stringify({ userCode: userCode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    try {

                        if (response.d == null) {
                            $('#tblVahed').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
                        }
                        else {
                            var count = 0;
                            var color;
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                count += 1;
                                if (count % 2 == 0) {
                                    color = '#AAFFAA ';
                                }
                                else {
                                    color = ' #f2f2f2';
                                }
                                $('#tblVahed').append('<tr style="background-color: ' + color + '" id="row_' + c.id + '"><td id="1col_' + c.id + '" style="text-align:center">' +
                                    count + '</td>' +
                                  '<td id="2col_' + c.id + '" style="text-align:center">' +
                                    c.vahedCode + '</td>' +
                                  '<td id="3col_' + c.id + '" style="text-align:center">' +
                                    c.vahedName + '</td>' +
                                  '<td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.id
                                    + '" </i></td>');
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

        function SearchInTable(Name, UserName) {

            $('#TblUser').empty();
            $.ajax({
                type: "POST",
                url: "UserManage.aspx/SearchInTable",
                data: JSON.stringify({ Name: Name, UserName: UserName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    try {

                        if (response.d == null) {
                            $('#TblUser').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
                        }
                        else {
                            var count = 0;
                            var color;
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                count += 1;
                                if (count % 2 == 0) {
                                    color = '#AAFFAA ';
                                }
                                else {
                                    color = ' #f2f2f2';
                                }
                                $('#TblUser').append('<tr style="background-color: ' + color + '" id="row_' + c.userCode + '">' +
                                    '<td id="1col_' + c.userCode + '" style="text-align:center">' + c.userCode + '</td>' +
                                    '<td id="2col_' + c.userCode + '" style="text-align:center">' + c.Name + '</td>' +
                                    '<td id="3col_' + c.userCod + '" style="text-align:center">' + c.userName + '</td>' +
                                    '<td id="2col_' + c.userCode + '" style="text-align:center">' + c.mobile + '</td>' +
                                    '<td id="2col_' + c.userCode + '" style="text-align:center">' + c.email + '</td>' +
                                     '<td class="edit-remove"><i class="edite fa fa-edit " style="cursor: pointer" id="edit' + c.userCode
                                   + '" </i></td><td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.userCode
                                    + '" </i></td>');

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

        //function emptyElements(container) {
        //    var strContainer = '#' + container;
        //    $('input[type=text]', strContainer).each(function (element) {
        //        $(this).val('');
        //    });
        //    $('select', strContainer).each(function (element) {
        //        $(this).find('option:selected').val("");
        //    });
        //};

        function fillModal(id) {
            var userCode = id;

            $.ajax({
                type: "POST",
                url: "UserManage.aspx/UserReqSeByUserCode",
                data: JSON.stringify({ userCode: userCode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    try {

                        if (response.d == null) {
                            $('#TblSoftware').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
                        }
                        else {
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                $('#FName').val(c.fName);
                                $('#LName').val(c.lName);
                                $('#UserName').val(c.userName);
                                $('#Pass').val(c.pass);
                                $('#Email').val(c.email);
                                $('#Mobile').val(c.mobile);
                                $('#ddVahed').prop('selectedIndex', c.vahedCode);
                                $('#ddZone').prop('selectedIndex', c.zoneCode);


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

        function UpdateReq(id) {
            var request = {};
            request.userCode = id;
            request.fName = $('#FName').val();
            request.lName = $('#LName').val();
            request.userName = $('#UserName').val();
            request.pass = $('#Pass').val();
            request.email = $('#Email').val();
            request.mobile = $('#Mobile').val();
            request.zoneCode = $('#ddZone').find('option:selected').val();

            try {
                $.ajax({
                    type: "POST",
                    url: "UserManage.aspx/UpdateReqUser",
                    data: JSON.stringify({ rn: request }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var result = $.parseJSON(response.d);
                        if (result.IsSuccessfull) {
                            $('#lblMessage').text('ثبت اطلاعات با موفقیت انجام شد');
                            UserReq();

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
        };

        function deleteUser(id) {
            var userCode = id;
            $.ajax({
                type: "POST",
                url: "userManage.aspx/deleteUser",
                data: JSON.stringify({ userCode: userCode }),
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

        function deleteVahedUser(id) {
            var id = id;
            $.ajax({
                type: "POST",
                url: "userManage.aspx/deleteVahedUser",
                data: JSON.stringify({ id: id }),
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

        function addToTableVahed() {
            var i = $(document).data('i');
            i++;
            var color = '';
            if (i % 2 == 0) {
                color = '#eaf6fd ';
            }
            else {
                color = ' #f2f2f2';
            }


            var vahedName = $('#ddVahed').find('option:selected').text();
            var vahedCode = $('#ddVahed').find('option:selected').val();
            $('#tblVahed').append('<tr class="addItem" style="background-color: ' + color + '" id="ROW_' + i + '"><td id="1col_' + i + '" style="text-align:center">' +
                               i + '</td><td id="2col_' + i + '" style="text-align:center">' +
                               vahedCode + '</td><td id="3col_' + i + '" style="text-align:center">' +
                               vahedName + '</td>'
                               + '<td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + i
                                 + '" </i></td>');

            $(document).data('i', i);
        };

        function  checkUserName(userName)
        {
            
            $.ajax({
                type: "POST",
                url: "userManage.aspx/checkUserName",
                data: JSON.stringify({ userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    try {
                        var result = $.parseJSON(response.d);
                        if (!result.IsSuccessfull) {
                            alert("نام کاربری تکراری است");
                            $("#UserName").val('');
                        }
                           
                    }
                    catch (err) {
                    }
                },
                error: function (response) {
                   
                }
            });
        }
    </script>

    <%-------------------------------------------------------------------DocumentReady--------------------------------------------------------------------------------%>
    <script type="text/javascript">

        $(document).ready(function () {
            $('.date').datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: "-90:+0"
            });

            onlyNumber();
            checkLenght();
            changeValid();
           
            $('#Mobile').data('lenght', '11');
            var id;
            $('#txtuserName').keydown(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSearchUserName').focus();
                }
            });
            $('#txtName').keydown(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSearchName').focus();
                }
            });
            $("#UserName").change(function () {
                checkUserName($("#UserName").val());



            });
            
            $("#repeatPass").change(function () {
                if ($("#Pass").val() != $("#repeatPass").val()) {
                    alert("کلمه عبور با مقدار وارد شده ی قبلی مطابقت ندارد");
                    $("#repeatPass").val('');
                }

            })
            FillCmbVahedAddUser();
            FillCmbZoneAddUser();
            $("#btnAdd").click(function () {
                FillCmbVahedAddUser();
                FillCmbZoneAddUser();
                $(document).data('i', '0');
                emptyElements('myModal');
                $('#tblVahed').empty();
                $('#btnUpdate').hide();
                $('#btnSave').show();
            });
            $('#btnSave').click(function () {
                if (valid('myModal') == true) {
                    createReq();
                    $("#myModal").modal("hide");
                }
            });
            $('#btnUpdate').click(function () {
                UpdateReq(id);
                $("#myModal").modal("hide");
            });
            $('#btnSearchName').click(function () {

                var Name = $('#txtName').val();
                var UserName = $('#txtuserName').val();
                SearchInTable(Name, UserName);
            });
            $('#btnSearchUserName').click(function () {

                var Name = $('#txtName').val();
                var UserName = $('#txtuserName').val();
                SearchInTable(Name, UserName);
            });
            // *********************validNationalCode**************
            //$('#Mobile').change(function () {
            //    if (validNationalCode($('#Mobile').val()) == true)
            //    {
            //        alert('t');
            //    }
            //    else
            //    {
            //        alert('f');
            //    }
            //})
            $("#modalAdd").click(function () {
                //   if ($("#InsertForm").valid() === true) {
                alert('true');
                // }
            })
            UserReq();

            $("#TblUser").on('click', 'i.delete', function () {
                id = $(this).attr("id").replace("delete", "");
                var e = confirm("آیا مطمئن هستید؟");
                if (e == true) {
                    deleteUser(id);
                    UserReq();
                }
            });
            $("#TblUser").on('click', 'i.edite', function () {
                id = $(this).attr("id").replace("edit", "");
                $("#myModal").modal("show");
                fillModal(id);
                VahedUserReq(id);
                $('#btnUpdate').show();
                $('#btnSave').hide();
            });
            $("#tblVahed").on('click', 'i.delete', function () {
                id = $(this).attr("id").replace("delete", "");
                $(this).closest('tr').remove();
                // deleteVahedUser(id);

                // VahedUserReq(id);

            });
            $("#btnAddVahed").click(function () {
                addToTableVahed();
            });

        });
    </script>
    <%--------------------------------------------------------------------End Script-----------------------------------------------------------------------------------------%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-title"><span>اطلاعات کاربران</span></div>
        <div class="panel-body">
            <div class="form-group col-md-4">
                <div class="input-group">
                    <span class="input-group-addon">نام و نام خانوادگی</span>
                    <input type="text" class="form-control" id="txtName" placeholder="متن مورد نظر را وارد نمایید" aria-describedby="basic-addon1" />
                    <span class="input-group-btn">
                        <button type="button" id="btnSearchName" class="btn btn-success"><i class="fa fa-search"></i></button>
                    </span>
                </div>
            </div>
            <div class="form-group col-md-4">
                <div class="input-group">
                    <span class="input-group-addon">نام کاربری</span>
                    <input type="text" class="form-control" id="txtuserName" placeholder="متن مورد نظر را وارد نمایید" aria-describedby="basic-addon1" />
                    <span class="input-group-btn">
                        <button type="button" id="btnSearchUserName" class="btn btn-success"><i class="fa fa-search"></i></button>
                    </span>
                </div>
            </div>
            <div class="form-group col-md-4">
                <div class="btn-group pull-left" role="group" aria-label="basic-addon1">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal" id="btnAdd" data-target=".bs-example-modal-lg"><i class="fa fa-plus"></i>&nbsp;ثبت کاربر جدید</button>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="form-group col-md-12">
                <hr />
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th class="head-title">کد کاربر</th>
                                    <th class="head-title">نام و نام خانوادگی</th>
                                    <th class="head-title">نام کاربری</th>
                                    <th class="head-title">شماره موبایل</th>
                                    <th class="head-title">ایمیل</th>
                                    <th class="head-title edit-remove">ویرایش</th>
                                    <th class="head-title edit-remove">حذف</th>
                                </tr>
                            </thead>
                            <tbody id="TblUser">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="form-group">
                    <nav class="pull-right">
                        <ul class="pagination">
                            <li>
                                <a href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li class="active"><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li>
                                <a href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

        </div>
    </div>
    <%---------------------------------------------------------------------Modal------------------------------------------------------------------------------------------------%>
    <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="gridSystemModalLabel">ایجاد کاربر جدید</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">


                        <div class="row">
                            <div class="col-md-10">
                                <div class="form-group">
                                    <div class="input-group col-md-12 ">
                                        <span class="input-group-addon">نام</span>
                                        <input type="text" class="form-control required" id="FName" placeholder="نام را وارد نمایید" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">نام خانوادگی</span>
                                        <input type="text" class="form-control required" id="LName" placeholder="نام خانوادگی را وارد نمایید" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">نام کاربری</span>
                                        <input type="text" class="form-control required" id="UserName" placeholder="نام کاربری را وارد نمایید" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">رمز عبور</span>
                                        <input type="password" class="form-control  user-pass required" id="Pass" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">تکرار رمز عبور</span>
                                        <input type="password" class="form-control  user-pass required" id="repeatPass" aria-describedby="basic-addon1" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">نام حوزه</span>
                                        <select data-width="25%" id="ddZone" class="form-control required">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">آدرس ایمیل</span>
                                        <input type="text" class="form-control " id="Email" placeholder="ایمیل را وارد نمایید" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">شماره موبایل</span>
                                        <input type="text" class="form-control onlyNumber lenght " id="Mobile" placeholder="شماره موبایل را وارد نمایید" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class=" col-md-10">
                                <div class="form-group col-md-10" style="padding-right: 0px">
                                    <div class="input-group">
                                        <span class="input-group-addon">نام واحد سازمانی</span>
                                        <select data-width="25%" id="ddVahed" class="form-control required">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-md-2" style="padding-left: 0px">
                                    <div class="input-group pull-left">
                                        <button type="button" id="btnAddVahed" class="btn btn-success">اضافه</button>
                                    <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <hr />
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th class="head-title">ردیف</th>
                                        <th class="head-title">کد واحد</th>
                                        <th class="head-title">نام واحد سازمانی</th>
                                        <th class="head-title edit-remove">حذف</th>
                                    </tr>
                                </thead>
                                <tbody id="tblVahed">
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>




                <div class="modal-footer">
                    <span id="lblMessage"></span>
                    <button type="button" id="btnUpdate" class="btn btn-success">ویرایش اطلاعات</button>
                    <button type="button" id="btnSave" class="btn btn-success">ذخیره اطلاعات</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">انصراف</button>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
