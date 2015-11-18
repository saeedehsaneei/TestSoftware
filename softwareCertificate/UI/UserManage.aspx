<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Main.Master" AutoEventWireup="true" CodeBehind="UserManage.aspx.cs" Inherits="softwareCertificate.UI.UserManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #myModal .modal-dialog {
            width: 40%;
        }
    </style>
    <%-------------------------------------------------------------------Function------------------------------------------------------------------------------%>
    <script type="text/javascript">
        function readReferencesCountForSearch() {
            return $(document).data("countTotal");
        }

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
                vahedReqType.vahedCode = $('#ROW_' + j + ' td:nth-child(2)').text();
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
                            // $('#lblMessage').text('ثبت اطلاعات با موفقیت انجام شد');
                            alert('ثبت اطلاعات با موفقیت انجام شد');
                            loadGrid('TblUser', readReferencesCountForSearch, UserReq);

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
            $('#ddVahed').append(' <option value="">انتخاب کنید</option>');
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

        function UserReq(firstRow) {
            $(document).data('countTotal', '0');
            $('#TblUser').empty();
            $.ajax({
                type: "POST",
                url: "UserManage.aspx/UserReqSe",
                data: JSON.stringify({ firstRow: firstRow }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
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
                                if (c.cnt == null)
                                    $('#TblUser').append('<tr style="background-color: ' + color + '" id="row_' + c.userCode + '"><td id="1col_' + c.userCode + '" style="text-align:center;width:5%">' +
                                    c.RowNo + '</td><td id="2col_' + c.userCode + '" style="text-align:center;">' +
                                    c.Name + '</td><td id="3col_' + c.userCod + '" style="text-align:center">' +
                                    c.userName + '</td>' +
                                  '<td id="2col_' + c.userCode + '" style="text-align:center">' +
                                    c.mobile + '</td><td id="2col_' + c.userCode + '" style="text-align:center">' +
                                    c.email + '</td>' +
                                  '<td class="edit-remove"><i class="edite fa fa-edit " style="cursor: pointer" id="edit' + c.userCode
                                   + '" </i></td><td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.userCode
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
                                $('#tblVahed').append('<tr style="background-color: ' + color + '" id="ROW' + c.id + '"><td id="1col_' + c.id + '" style="text-align:center">' +
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

        function SearchInTable(firstRow) {
            $(document).data('countTotal', '0');
            $('#TblUser').empty();
            var arr = $(document).data('arrData');
            $.ajax({
                type: "POST",
                url: "UserManage.aspx/SearchInTable",
                // data: JSON.stringify({ Name: Name, UserName: UserName }),
                data: JSON.stringify({ Name: arr[0], UserName: arr[1], firstRow: firstRow }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
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
                                if (c.cnt == null)
                                    $('#TblUser').append('<tr style="background-color: ' + color + '" id="row_' + c.userCode + '">' +
                                        '<td id="1col_' + c.userCode + '" style="text-align:center;width:5%">' + c.RowNo + '</td>' +
                                        '<td id="2col_' + c.userCode + '" style="text-align:center">' + c.Name + '</td>' +
                                        '<td id="3col_' + c.userCod + '" style="text-align:center">' + c.userName + '</td>' +
                                        '<td id="2col_' + c.userCode + '" style="text-align:center">' + c.mobile + '</td>' +
                                        '<td id="2col_' + c.userCode + '" style="text-align:center">' + c.email + '</td>' +
                                         '<td class="edit-remove"><i class="edite fa fa-edit " style="cursor: pointer" id="edit' + c.userCode
                                       + '" </i></td><td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.userCode
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
                                // $('#Pass').val(c.pass);
                                $('#Email').val(c.email);
                                $('#Mobile').val(c.mobile);
                                $('#ddVahed').prop('selectedIndex', c.vahedCode);
                                $('#ddZone').prop('selectedIndex', c.zoneCode);
                                $('#Pass').val('');
                                $('#repeatPass').val('');

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

        function UpdateReq(userCode) {

            var request = {};
            request.userCode = userCode;
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
                            // $('#lblMessage').text('ثبت اطلاعات با موفقیت انجام شد');
                            alert('ویرایش اطلاعات با موفقیت انجام شد');
                            loadGrid('TblUser', readReferencesCountForSearch, UserReq);

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

        function UpdateVahedUser(userCode) {
            var userCode = userCode;
            var arrType = new Array();
            var j = 1;
            $.each($('#tblVahed tr'), function (index) {
                var vahedReqType = {};
                vahedReqType.vahedCode = $('#ROW_' + j + ' td:nth-child(2)').text();
                arrType.push(vahedReqType);
                j++;

            });
            try {
                $.ajax({
                    type: "POST",
                    url: "UserManage.aspx/UpdateVahedUser",
                    data: JSON.stringify({ rgr: arrType, userCode: userCode }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var result = $.parseJSON(response.d);
                        if (result.IsSuccessfull) {
                            // $('#lblMessage').text('ثبت اطلاعات با موفقیت انجام شد');
                            //  alert('ثبت اطلاعات با موفقیت انجام شد');
                            // UserReq();

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

        function RowCount() {
            var j = 0;
            $.each($('#tblVahed tr'), function (index) {

                j++;
            });
            return j;
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
                        loadGrid('TblUser', readReferencesCountForSearch, UserReq);
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
            var i2 = 0;
            $.each($('#tblVahed tr'), function (index) {
                i2++;
            });
            if (i2 == 0)
                var i = $(document).data('i');
            else
                var i = i2;
            i++;
            var color = '';
            if (i % 2 == 0) {
                color = '#eaf6fd';
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

        function checkUserName(userName) {

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
        var id;
        var userCode;
        $(document).ready(function () {

            onlyNumber();
            checkLenght();
            changeValid();
            bindPager('RequestPager');
            loadGrid('TblUser', readReferencesCountForSearch, UserReq);

            $('#Mobile').data('lenght', '11');

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

            });
            FillCmbVahedAddUser();
            FillCmbZoneAddUser();
            $("#btnAdd").click(function () {
                FillCmbVahedAddUser();
                FillCmbZoneAddUser();
                validBack('myModal');
                $(document).data('i', '0');
                emptyElements('myModal');
                $('#Pass').val('');
                $('#repeatPass').val('');
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
                if (valid('myModal') == true) {
                    UpdateReq(userCode);
                    UpdateVahedUser(userCode);
                    $("#myModal").modal("hide");
                }
            });

            $('#btnSearchName').click(function () {

                var Name = $('#txtName').val();
                var UserName = $('#txtuserName').val();
                var data = [Name, UserName];
                $(document).data('arrData', data);
                loadGrid('TblUser', readReferencesCountForSearch, SearchInTable);
            });

            $('#btnSearchUserName').click(function () {

                var Name = $('#txtName').val();
                var UserName = $('#txtuserName').val();
                var data = [Name, UserName];
                $(document).data('arrData', data);
                loadGrid('TblUser', readReferencesCountForSearch, SearchInTable);
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
            });


            $("#TblUser").on('click', 'i.delete', function () {
                id = $(this).attr("id").replace("delete", "");
                var e = confirm("آیا مطمئن هستید؟");
                if (e == true) {
                    deleteUser(id);
                    loadGrid('TblUser', readReferencesCountForSearch, UserReq);
                }
            });

            $("#TblUser").on('click', 'i.edite', function () {
                id = $(this).attr("id").replace("edit", "");
                userCode = id;
                $("#myModal").modal("show");
                validBack('myModal');
                fillModal(id);
                $(document).data('i', '0');
                VahedUserReq(id);
                $('#btnUpdate').show();
                $('#btnSave').hide();
            });

            $("#tblVahed").on('click', 'i.delete', function () {
                id = $(this).attr("id").replace("delete", "");
                //$(this).parent().parent().attr('id');

                $('#ROW_' + id).remove();
                var len = $('#tblVahed tr').length;
                if (len > 0) {
                    var n = 0;
                    $.each($('#tblVahed tr'), function (index) {
                        n++;
                        $(this).attr('id', 'ROW_' + n)
                        $(this).find("td").eq(0).text(n);
                        $(this).children().children('.delete').attr('id', 'delete' + n);
                    });
                    $(document).data('i', n);
                }
                else {
                    $(document).data('i', 0);
                }

            });

            $("#btnAddVahed").click(function () {
                if (valid('myModal') == true) {
                    addToTableVahed();
                }
            });

        });
    </script>
    <%--------------------------------------------------------------------End Script-----------------------------------------------------------------------------------------%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-title"><span><i class='fa fa-users'></i>&nbsp;اطلاعات کاربران</span></div>
        <div class="panel-body">
            <div class="row back-top-box">
            <div class="form-group col-md-4">
                <div class="input-group">
                    <span class="input-group-addon">نام و نام خانوادگی</span>
                    <input type="text" class="form-control" id="txtName"  aria-describedby="basic-addon1" />
                    <span class="input-group-btn">
                        <button type="button" id="btnSearchName" class="btn btn-success"><i class="fa fa-search"></i></button>
                    </span>
                </div>
            </div>
            <div class="form-group col-md-4">
                <div class="input-group">
                    <span class="input-group-addon">نام کاربری</span>
                    <input type="text" class="form-control" id="txtuserName"  aria-describedby="basic-addon1" />
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
                </div>
           
            <div class="row table-padding">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th class="head-title">ردیف</th>
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
                                            <input style="width: 70px; text-align: center" id="TxtPager" name="TxtPager" type="text" readonly="readonly" />
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
    <%---------------------------------------------------------------------Modal------------------------------------------------------------------------------------------------%>
    <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="gridSystemModalLabel"><i class='fa fa-user'></i>&nbsp;ایجاد کاربر جدید</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="back-top-box" style="margin:0;">
                        <div class="row col-md-padding">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="input-group col-md-12 ">
                                        <span class="input-group-addon">نام</span>
                                        <input type="text" class="form-control required" id="FName"  aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">نام خانوادگی</span>
                                        <input type="text" class="form-control required" id="LName"  aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">نام کاربری</span>
                                        <input type="text" class="form-control required" id="UserName"  aria-describedby="basic-addon1" />
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
                                        <input type="text" class="form-control " id="Email"  aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <span class="input-group-addon">شماره موبایل</span>
                                        <input type="text" class="form-control onlyNumber lenght " id="Mobile" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-12">
                                <div class="input-group">
                                    <span class="input-group-addon">نام واحد سازمانی</span>
                                    <select data-width="25%" id="ddVahed" class="form-control required">
                                    </select>
                               
                                <span class="input-group-btn">
                                    <button type="button" id="btnAddVahed" class="btn btn-success pull-left">اضافه</button>
                                </span>
                                     </div>
                        </div>
                        </div>
                        </div>
                    </div>
                </div>
                <div class="row table-padding">
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
                <div class="modal-footer">
                    <%-- <span id="lblMessage"></span>--%>
                    <button type="button" id="btnUpdate" class="btn btn-success">ویرایش اطلاعات</button>
                    <button type="button" id="btnSave" class="btn btn-success">ذخیره اطلاعات</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">انصراف</button>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
