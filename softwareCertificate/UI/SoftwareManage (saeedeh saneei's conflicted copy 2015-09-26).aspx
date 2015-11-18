<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Main.Master" AutoEventWireup="true" CodeBehind="SoftwareManage.aspx.cs" Inherits="softwareCertificate.UI.SoftwareManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
            #myModal .modal-dialog {
                width: 75%;
            }
        </style>
    <script type="text/javascript">

        function search() {
            if ($('#ddSearch').find('option:selected').val() == 1) {
                $('#DivCompany').hide();
                $('#DivVahed').hide();
                $('#DivSDate').hide();
                $('#DivSoftware').show();

            }
            else if ($('#ddSearch').find('option:selected').val() == 2) {
                $('#DivSoftware').hide();
                $('#DivVahed').hide();
                $('#DivSDate').hide();
                $('#DivCompany').show();

            } else if ($('#ddSearch').find('option:selected').val() == 3) {
                $('#DivSoftware').hide();
                $('#DivCompany').hide();
                $('#DivSDate').hide();
                $('#DivVahed').show();
            } else {
                $('#DivSoftware').hide();
                $('#DivCompany').hide();
                $('#DivVahed').hide();
                $('#DivSDate').show();
            }
        };
        function deleteSoftware(id) {

            var softwareCode = id;
            $.ajax({
                type: "POST",
                url: "softwareManage.aspx/deleteSoftware",
                data: JSON.stringify({ softwareCode: softwareCode }),
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



        $(document).ready(function () {
            var code = 0;
            var softwareCode;
            $('#txtSoftwareName').keydown(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSearchSoftware').focus();
                }
            })
            $('#txtCompanyName').keydown(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSearchCompany').focus();
                }
            })
            $('#DivCompany').hide();
            $('#DivVahed').hide();
            $('#DivSDate').hide();
            FillCmbVahedAddSoftware();
            FillCmbZoneAddSoftware();
            FillCmbLanguageAddSoftware();
            FillCmbMemariAddSoftware();
            FillCmbMemariAddSoftware();
            FillCmbDbAddSoftware();
            $("#btnAdd").click(function () {
                $("#myModal :input").removeAttr("disabled");
                FillCmbVahedAddSoftware();
                FillCmbZoneAddSoftware();
                FillCmbLanguageAddSoftware();
                FillCmbMemariAddSoftware();
                FillCmbDbAddSoftware();
                emptyElements('myModal');
                $('#btnCancel').show();
                $('#btnAdd1').show();
                $('#btnSave').show();
                $('#btnEdit').hide();

            });
            $("#btnAdd1").click(function () {
                FillCmbVahedAddSoftware();
                emptyElements('myModal1');
            });
            $('#btnEdit').click(function () {
                UpdateReq(softwareCode);
                $("#myModal").modal("hide");
            });
            $('#btnSave1').click(function () {
                code = 1;
                alert('اطلاعات با موفقیت ثبت شد');
                $("#myModal1").modal("hide");
            });
            $('#btnSearchCompany').click(function () {
                fillAndSearchTable();
            });
            $('#btnSearchSoftware').click(function () {
                fillAndSearchTable();
            });
            $('#btnSearch').click(function () {
                fillAndSearchTable()

            });
            $('#btnSearchDate').click(function () {
                fillAndSearchTable()

            });
            $("#TblSoftware").on('click', '.detail', function () {
                emptyElements('myModal');
                $('#btnSave').hide();
                $('#btnEdit').hide();
                $('#btnCancel').hide();
                $('#btnAdd1').hide();
                id = $(this).attr("id").replace("detail", "");
                $("#myModal").modal("show");
                $("#myModal :input").attr("disabled", true);
                $("#close").removeAttr("disabled");
                fillModal(id);

            });
            $('#btnSave').click(function () {
                createReq();
                $("#myModal").modal("hide");
            });
            function fillAndSearchTable() {
                var ZoneValue = $('#ddZone1').find('option:selected').val();
                var VahedValue = $('#ddVahed1').find('option:selected').val();
                var SoftwareName = $('#txtSoftwareName').val();
                var CompanyName = $('#txtCompanyName').val();
                var StartDate = $('#txtStartDate').val();
                var EndDate = $('#txtEndDate').val();
                if ($('#ddSearch').find('option:selected').val() == 1) {
                    CompanyName = "";
                    StartDate = "";
                    EndDate = "";
                    VahedValue = 0;
                    ZoneValue = 0;
                }
                else if ($('#ddSearch').find('option:selected').val() == 2) {
                    SoftwareName = "";
                    StartDate = "";
                    EndDate = "";
                    VahedValue = 0;
                    ZoneValue = 0;

                } else if ($('#ddSearch').find('option:selected').val() == 3) {
                    SoftwareName = "";
                    CompanyName = "";
                    StartDate = "";
                    EndDate = "";
                }
                else {
                    CompanyName = "";
                    SoftwareName = "";
                    VahedValue = 0;
                    ZoneValue = 0;
                }
                SearchInTable(SoftwareName, CompanyName, VahedValue, ZoneValue, StartDate, EndDate);
            };

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
                request.isSupport = $('#ddSupport10').find('option:selected').val();
                request.companyName = $('#Company').val();
                request.companyAddress = $('#Address').val();
                request.subject = $('#subject').val();
                request.endDateSupport = $('#EndDate').val();
                request.supportPrice = $('#SupportPrice').val();
                request.isUsed = $('#ddUse10').find('option:selected').val();
                request.instalationDate = $('#InstallDate').val();
                request.contractNumber = $('#BuyNumber').val();
                request.isHardwareLock = $('#ddLock').find('option:selected').val();
                request.isSource = $('#ddSource10').find('option:selected').val();
                request.lastDbVersion = $('#Version').val();
                request.supervisorName = $('#Supervisor').val();
                request.companyTell = $('#TelCo').val();
                request.companyNamayandeName = $('#NameN').val();
                request.supervisorTell = $('#Tel1').val();
                request.supportTell = $('#SupportTell').val();
                request.isReportCreate = $('#ddCreatReport10').find('option:selected').val();
                request.isFixReport = $('#ddReport10').find('option:selected').val();
                request.userCount = $('#UserCount').val();
                request.isDocument = $('#ddDoc10').find('option:selected').val();
                request.softwareProblem = $('#Problem').val();
                request.vahedCode = $('#ddVahed').find('option:selected').val();
                request.zoneCode = $('#ddZone').find('option:selected').val();
                request.isOpBuyer = $('#ddBuy10').find('option:selected').val();

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



            };

            function FillCmbVahedAddSoftware() {
                $('#ddVahed').empty();
                $('#ddVahed1').empty();
                $('#ddVahed2').empty();
                $('#ddVahed').append(' <option value="0">همه واحد ها</option>');
                $('#ddVahed1').append(' <option value="0">انتخاب کنید</option>');
                $('#ddVahed2').append(' <option value="0">انتخاب کنید</option>');
                try {
                    $.ajax({
                        type: "POST",
                        url: "SoftwareManage.aspx/FillCmbVahedAddSoftware",
                        data: "{}",//read only az db
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        //async:false,
                        success: function (response) {
                            var result = $.parseJSON(response.d);
                            $.each(result.Value, function (index, c) {
                                $('<option value="' + c.vahedCode + '">' + c.vahedName + '</option>').appendTo("#ddVahed");
                                $('<option value="' + c.vahedCode + '">' + c.vahedName + '</option>').appendTo("#ddVahed1");
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
            };

            function FillCmbZoneAddSoftware() {
                $('#ddZone').empty();
                $('#ddZone1').empty();
                $('#ddZone').append(' <option value="0">انتخاب کنید</option>');
                $('#ddZone1').append(' <option value="0">همه واحد ها</option>');
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
                                $('<option value="' + c.zoneCode + '">' + c.zoneName + '</option>').appendTo("#ddZone1");

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
            };

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
            };

            function FillCmbDbAddSoftware() {
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
                    });
                }

                catch (e) {
                    alert("اشکال در خواندن اطلاعات");
                }
            };

            function SoftwareReq(userCode) {

                $('#TblSoftware').empty();
                $.ajax({
                    type: "POST",
                    url: "SoftwareManage.aspx/SoftwareReqSe",
                    data: JSON.stringify({ userCode: userCode }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        try {

                            if (response.d == null) {
                                $('#TblSoftware').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
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
                                    $('#TblSoftware').append('<tr style="background-color: ' + color + '" id="row_' + c.softwareCode + '"><td id="1col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.softwareCode + '</td><td id="2col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.softwareName + '</td><td id="3col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.vahedName + '</td><td id="3col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.zoneName + '</td><td id="3col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.companyName + '</td><td id="3col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.endDateSupport + '</td>' +
                                       '<td class="edit-remove"><i class="detail fa fa-book fa-fw" style="cursor: pointer" id="detail' + c.softwareCode
                                       + '"</i></td><td class="edit-remove"><i class="edit fa fa-edit " style="cursor: pointer" id="edit' + c.softwareCode
                                   + '" </i></td><td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.softwareCode
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

            function SearchInTable(SoftwareName, CompanyName, VahedValue, ZoneValue, StartDate, EndDate) {

                $('#TblSoftware').empty();
                $.ajax({
                    type: "POST",
                    url: "SoftwareManage.aspx/SofSearchInTable",
                    data: JSON.stringify({ SoftwareName: SoftwareName, CompanyName: CompanyName, VahedValue: VahedValue, ZoneValue: ZoneValue, StartDate: StartDate, EndDate: EndDate }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        try {

                            if (response.d == null) {
                                $('#TblSoftware').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
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
                                    $('#TblSoftware').append('<tr style="background-color: ' + color + '" id="row_' + c.softwareCode + '"><td id="1col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.softwareCode + '</td><td id="2col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.softwareName + '</td><td id="3col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.vahedName + '</td><td id="3col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.zoneName + '</td><td id="3col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.companyName + '</td><td id="3col_' + c.softwareCode + '" style="text-align:center">' +
                                        c.endDateSupport + '</td>'
                                       + '<td class="edit-remove"><i class="detail fa fa-book fa-fw" style="cursor: pointer" id="detail' + c.softwareCode
                                       + '"</i></td><td class="edit-remove"><i class="edit fa fa-edit " style="cursor: pointer" id="edit' + c.softwareCode
                                       + '" </i></td><td class="edit-remove"><i  class="delete fa fa-times " style="cursor: pointer" id="delete' + c.softwareCode
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

            function emptyElements(container) {
                var strContainer = '#' + container;
                $('input[type=text]', strContainer).each(function (element) {
                    $(this).val('');
                });
                $('select', strContainer).each(function (element) {
                    $(this).prop('selectedIndex', 0);


                });
                $('input[type=checkbox]', strContainer).each(function (element) {
                    if ($(this).prop("checked") == true) {
                        $(this).prop('checked', false);
                    }
                });

            };

            function fillModal(id) {
                softwareCode = id;
                $.ajax({
                    type: "POST",
                    url: "SoftwareManage.aspx/SoftwareReqSeBySoft",
                    data: JSON.stringify({ softwareCode: softwareCode }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (response) {
                        try {

                            if (response.d == null) {
                                $('#TblSoftware').append('<tr><td colspan="6"> یافت نشد.</td></tr>');
                            }
                            else {
                                var result = $.parseJSON(response.d);

                                $.each(result.Value, function (index, c) {
                                    $('#Company').val(c.companyName);
                                    $('#Address').val(c.companyAddress);
                                    $('#subject').val(c.subject);
                                    $('#EndDate').val(c.endDateSupport);
                                    $('#SupportPrice').val(c.supportPrice);
                                    $('#ddVahed').val(c.vahedCode);
                                    $('#ddZone').val(c.zoneCode);
                                    $('#ddLanguage').val(c.languageCode);
                                    $('#ddmemari').val(c.memariCode);
                                    $('#ddDb').prop('selectedIndex', c.dbCode);
                                    $('#Name').val(c.softwareName);
                                    $('#Version').val(c.lastDbVersion);
                                    $('#TelCo').val(c.companyTell);
                                    $('#Address').val(c.companyAddress);
                                    $('#NameN').val(c.companyNamayandeName);
                                    $('#Supervisor').val(c.supervisorName);
                                    $('#Tel1').val(c.supervisorTell);
                                    $('#Price').val(c.softwarePrice);
                                    $('#BuyNumber').val(c.contractNumber);
                                    $('#InstallDate').val(c.instalationDate);
                                    $('#EndDate').val(c.endDateSupport);
                                    $('#SupportTell').val(c.supportTell);
                                    $('#UserCount').val(c.userCount);
                                    $('#ServerLocation').val(c.serverLocation);



                                    $('#ddLock10').val(c.isHardwareLock);
                                    $('#ddDoc10').val(c.isDocument);
                                    $('#ddBuy10').val(c.isOpBuyer);
                                    $('#ddReport10').val(c.isFixReport);
                                    $('#ddCreatReport10').val(c.isReportCreate);
                                    $('#ddUse10').val(c.isUsed);
                                    $('#ddSource10').val(c.isSource);
                                    $('#ddSupport10').val(c.isSupport);

                                    if (c.isPatchUpdate == '1') {
                                        $('#PatchUpdate1').prop('checked', true);
                                       
                                    } else {
                                        $('#PatchUpdate1').prop('checked', false);
                                        
                                    }
                                    if (c.isFtpUpdate == '1') {
                                        $('#FtpUpdate1').prop('checked', true);
                                    } else {
                                        $('#FtpUpdate1').prop('checked', false);
                                    }
                                    if (c.isDirectAccessUpdate == '1') {
                                        $('#DirectAccessUpdate1').prop('checked', true);
                                    } else {
                                        $('#DirectAccessUpdate1').prop('checked', false);
                                    }
                                    if (c.isOtherUpdate = '1') {
                                        $('#test1').prop('checked', true);
                                    } else {
                                        $('#test1').prop('checked', false);
                                    }

                                    //alert(h);

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

            function UpdateReq(softwareCode) {

                var request = {};
                request.softwareCode = softwareCode;
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
                request.isSupport = $('#ddSupport10').find('option:selected').val();
                request.companyName = $('#Company').val();
                request.companyAddress = $('#Address').val();
                request.subject = $('#subject').val();
                request.endDateSupport = $('#EndDate').val();
                request.supportPrice = $('#SupportPrice').val();
                request.isUsed = $('#ddUse10').find('option:selected').val();
                request.instalationDate = $('#InstallDate').val();
                request.contractNumber = $('#BuyNumber').val();
                request.isHardwareLock = $('#ddLock').find('option:selected').val();
                request.isSource = $('#ddSource10').find('option:selected').val();
                request.lastDbVersion = $('#Version').val();
                request.supervisorName = $('#Supervisor').val();
                request.companyTell = $('#TelCo').val();
                request.companyNamayandeName = $('#NameN').val();
                request.supervisorTell = $('#Tel1').val();
                request.supportTell = $('#SupportTell').val();
                request.isReportCreate = $('#ddCreatReport10').find('option:selected').val();
                request.isFixReport = $('#ddReport10').find('option:selected').val();
                request.userCount = $('#UserCount').val();
                request.isDocument = $('#ddDoc10').find('option:selected').val();
                request.softwareProblem = $('#Problem').val();
                request.vahedCode = $('#ddVahed').find('option:selected').val();
                request.zoneCode = $('#ddZone').find('option:selected').val();
                request.isOpBuyer = $('#ddBuy10').find('option:selected').val();



                try {
                    $.ajax({
                        type: "POST",
                        url: "SoftwareManage.aspx/updateSoftReq",
                        data: JSON.stringify({ rn: request }),
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


            };

            $("#modalAdd").click(function () {
                //   if ($("#InsertForm").valid() === true) {
                alert('true');
                // }
            })
            SoftwareReq(0);
            var id;
            $("#TblSoftware").on('click', '.delete', function () {
                id = $(this).attr("id").replace("delete", "");
                var e = confirm("آیا مطمئن هستید؟");
                if (e == true) {
                    deleteSoftware(id);
                    SoftwareReq(0);
                }
            });
            $("#TblSoftware").on('click', '.edit', function () {
                id = $(this).attr("id").replace("edit", "");
                $('#btnSave').hide();
                $('#btnEdit').show();
                $('#btnCancel').show();
                $('#btnAdd1').hide();
                $("#myModal").modal("show");
                $("#myModal :input").removeAttr("disabled");
                fillModal(id);
            });
        });
    </script>
<%-----------------------------------------------------------------------------------------------------------------------------------------------------%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-title"><span>اطلاعات نرم افزارها</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group col-md-6">
                        <div class="input-group row-fluid ">
                            <span class="input-group-addon">نوع گزارشگیری</span>
                            <select onchange="search()" class="form-control" data-width="25%" id="ddSearch">
                                <option value="1" >نام نرم افزار</option>
                                <option value="2">شرکت تولید کننده</option>
                                <option value="3">واحد سازمانی</option>
                                <option value="4">تاریخ اتمام پشتیبانی</option>
                            </select>

                        </div>
                    </div>
                    <div class="form-group col-md-6">
                    <div class="input-group pull-left">
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal" id="btnAdd" data-target=".bs-example-modal-lg""><i class="fa fa-plus"></i>&nbsp;&nbsp;ثبت نرم افزار جدید</button>
                        <div class="clearfix"></div>
                    </div>
                </div>
                    </div>
                    </div>

                    <div class="col-md-12"><hr /></div>

                    <div class="row">
                      <div class="col-md-5">
                    <div class="form-group" id="DivCompany">
                        <div class="input-group">
                            <span class="input-group-addon">نام شرکت تولید کننده</span>
                            <input type="text" id="txtCompanyName" class="form-control" placeholder="نام شرکت را وارد نمایید" aria-describedby="basic-addon1" />
                            <span class="input-group-btn"><button type="button" id="btnSearchCompany" class="btn btn-success"><i class="fa fa-search"></i></button></span>
                        </div>
                    </div>
                       </div>
                    </div>
                    <div class="row">
                          <div class="col-md-5">
                    <div class="form-group" id="DivSoftware">
                           <div class="input-group">
                               <span class="input-group-addon"> نام نرم افزار</span>
                               <input type="text" id="txtSoftwareName" class="form-control" placeholder="نام نرم افزار را وارد نمایید" aria-describedby="basic-addon1" />
                               <span class="input-group-btn"><button type="button" id="btnSearchSoftware" class="btn btn-success"><i class="fa fa-search"></i></button></span>

                           </div>
                    </div>
                               </div>
                    </div>
                    <div class="row" id="DivVahed"> 
                         <div class="col-md-10">
                   
                         <div class="form-group col-md-5">
                        <div class="input-group ">
                            <span class="input-group-addon">نام واحد </span>
                            <select id="ddVahed1" data-width="25%" class="form-control">
                            </select>
                        </div>
                   </div>
                        <div class="form-group  col-md-5">
                            <div class="input-group">
                                <span class="input-group-addon">نام حوزه</span>
                                <select  id="ddZone1" data-width="25%" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="input-group">
                             <button type="button" class="btn btn-success" id="btnSearch"><i class="fa fa-search"></i>&nbsp;جستجو</button>
                        </div>
                   
                               </div>
                    </div>
                    <div class="row" id="DivSDate">
                          <div class="col-md-10">
                          <div class="form-group col-md-5">
                    <div class="input-group">
                        <span class="input-group-addon">تاریخ شروع</span>
                        <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" id="txtStartDate" />
                    </div>
                    </div>
                    <div class="form-group col-md-5">
                    <div class="input-group">
                        <span class="input-group-addon">تاریخ پایان</span>
                        <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" id="txtEndDate" />
                    </div>
                        </div>
                         <div class="input-group">
                             <button type="button" class="btn btn-success" id="btnSearchDate"><i class="fa fa-search"></i>&nbsp;جستجو</button>
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
                            
                            <th class="head-title">کد نرم افزار</th>
                            <th class="head-title">نام نرم افزار</th>
                            <th class="head-title">نام واحد سازمانی</th>
                            <th class="head-title">نام حوزه</th>
                            <th class="head-title">نام شرکت</th>
                            <th class="head-title">تاریخ اتمام پشتیبانی</th>
                           

                            
                            <th class="head-title edit-remove">جزییات</th>
                            <th class="head-title edit-remove">ویرایش</th>
                            <th class="head-title edit-remove">حذف</th>
                        </tr>
                    </thead>

                    <tbody id="TblSoftware">  
                   <tr>
                            
                  </tr>
                       
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
<%---------------------------------------------------------------------Modal----------------------------------------------------------------------------------%>
     <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" id="close" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="gridSystemModalLabel">تعریف اطلاعات نرم افزار</h4>
                </div>

                <div class="modal-body">
                 <div class="container-fluid">
                 <div class="row">
                 <div >
                    <div class="form-group ">
                        <div class="input-group col-md-4 row-fluid">
                            <span class="input-group-addon">نام شهر</span>
                            <select class="selectpicker" id="ddlCity" data-width="75%" >
                                <option>کرمان</option>
                             
                            </select>
                        </div>
                    </div>
                    <div class="form-group ">
                        <div class="input-group col-md-4">
                            <span class="input-group-addon">نام واحد</span>
                            <select  data-width="75%" id="ddVahed" class="form-control" >
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group col-md-4">
                            <span class="input-group-addon">حوزه نرم افزار</span>
                            <select  data-width="75%" id="ddZone"  class="form-control" >
                            </select>
                        </div>
                    </div>
                     </div>
                     </div>

                      <div class="col-md-12"><hr /></div>

                     <div class="row">
                            <div>
                                <div class="form-group ">
                                    <div class="input-group col-md-6">
                                        <span class="input-group-addon">نام  نرم افزار</span>
                                        <input type="text" id="Name" class="form-control" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                                <div class="form-group ">
                                    <div class="input-group col-md-6">
                                        <span class="input-group-addon">موضوع کاربرد نرم افزار</span>
                                        <input type="text" id="subject" class="form-control" aria-describedby="basic-addon1" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                        <div class="row">
                          <div>
                             <div class="form-group">
                             <div class="input-group col-md-4">
                            <span class="input-group-addon ">زبان برنامه نویسی</span>
                            <select  data-width="75%" id="ddLanguage"  class="form-control" >
                            </select>       

                        </div>
                    </div>
                             <div class="form-group">
                        <div class="input-group col-md-4">
                            <span class="input-group-addon">نوع پایگاه داده</span>
                            <select  data-width="75%" id="ddDb"  class="form-control" >
                            </select>  
                             </div>
                    </div>
                             <div class="form-group">
                        <div class="input-group col-md-4">
                            <span class="input-group-addon">معماری سیستم</span>
                            <select  data-width="75%" id="ddmemari"  class="form-control">
                            </select>       

                        </div>
                    </div>
                           
                          </div>
                            </div>

                      <div class="col-md-12"><hr /></div>

                        <div class="row">
                            <div>
                            <div class="form-group ">
                             <div class="input-group col-md-5">
                            <span class="input-group-addon">نام شرکت طرف قرارداد</span>
                            <input type="text" id="Company" class="form-control"  aria-describedby="basic-addon1" />
                        </div>
                    </div>
                            <div class="form-group">
                             <div class="input-group col-md-4">
                            <span class="input-group-addon">نام نماینده شرکت</span>
                            <input type="text" id="NameN" class="form-control"  aria-describedby="basic-addon1" />
                        </div>
                    </div>
                            <div class="form-group">
                              <div class="input-group col-md-3">
                            <span class="input-group-addon">آخرین نسخه</span>
                            <input type="text" class="form-control" id="Version"/>
                           </div>
                              </div>
                       </div>
                      </div>

                         <div class="row">
                          <div>
                            <div class="form-group ">
                             <div class="input-group col-md-5">
                            <span class="input-group-addon">  شماره تماس شرکت</span>
                            <input type="text" class="form-control" id="TelCo"/>
                            
                        </div>
                    </div>
                            <div class="form-group ">
                             <div class="input-group col-md-4">
                            <span class="input-group-addon">نام سوپروایزر اصلی</span>
                            <input type="text" class="form-control" id="Supervisor"  />
                        </div>
                    </div>
                             
                   
                           </div>
                           </div>
                    <br />
                          

                     
                     <div class="row">
                               <div class="form-group">
                            <div class="input-group col-md-12">
                            <span class="input-group-addon">آدرس</span>
                            <input type="text" class="form-control" id="Address" />
                            
                        </div>
                          </div>
                         </div>
                              
                      <div class="col-md-12"><hr /></div>
                        <div class="row">
                          <div>
                             <div class="form-group">
                             <div class="input-group col-md-4">
                            <span class="input-group-addon">مبلغ خرید(ریال)</span>
                            <input type="text" id="Price" class="form-control"  aria-describedby="basic-addon1" />
                             </div>
                             </div>
                        <div class="form-group">
                        <div class="input-group col-md-4">
                            <span class="input-group-addon">مبلغ قرارداد پشتیبانی(ریال)</span>
                            <input type="text" id="SupportPrice" class="form-control"  />
                        </div>
                    </div>
                             <div class="form-group">
                             <div class="input-group col-md-4">
                            <span class="input-group-addon">شماره قرارداد خرید</span>
                            <input type="text" class="form-control" id="BuyNumber" />
                        </div>
                    </div>
                              </div>
                            </div>
                      
                        <div class="row">
                          <div>
                            <div class="form-group">
                        <div class="input-group col-md-4">
                            <span class="input-group-addon">تاریخ نصب نرم افزار</span>
                            <input type="text" id="InstallDate" class="form-control"  aria-describedby="basic-addon1" />
                        </div>
                    </div>
                            <div class="form-group">
                        <div class="input-group col-md-4">
                            <span class="input-group-addon">تاریخ اتمام پشتیبانی</span>
                            <input type="text" id="EndDate" class="form-control"  />
                        </div>
                    </div>
                            <div class="form-group">
                        <div class="input-group col-md-4">
                            <span class="input-group-addon"> شماره تماس پشتیبانی</span>
                            <input type="text" class="form-control" id="SupportTell"  />
                        </div>
                    </div>
                          </div>
                         </div>
              
                       <div class="col-md-12"><hr /></div>
                     
                   
                    
           
           
            
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="input-group col-md-12 ">
                            <span class="input-group-addon">قرارداد پشتیبانی</span>
                            <select data-width="75%" id="ddSupport10" class="form-control">
                                <option value='0'>ندارد</option>
                                <option value='1'>دارد</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group col-md-12">
                            <span class="input-group-addon">از نرم افزار استفاده میشود</span>
                            <select data-width="75%" id="ddUse10" class="form-control">
                                <option value="0">خیر</option>
                                <option value="1">بلی</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group col-md-12">
                            <span class="input-group-addon">قفل سخت افزاری</span>
                            <select data-width="75%" id="ddLock10" class="form-control">
                                <option value="0">ندارد</option>
                                <option value="1">دارد</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group col-md-12">
                            <span class="input-group-addon">sourc نرم افزار موجود است</span>
                            <select data-width="75%" id="ddSource10" class="form-control">
                                <option value="0">خیر</option>
                                <option value="1">بلی</option>

                            </select>
                        </div>
                    </div>

                </div>
                <div class="col-md-4">
                      <div class="form-group">
                    <div class="input-group col-md-12 ">
                       <span class="input-group-addon">نوع گزارشگیری سیستم</span>
                            <select data-width="75%" id="ddReport10" class="form-control">
                                <option value="0">ثابت</option>
                                <option value="1">پویا</option>
                            </select>    
                    </div>
               </div>
                      <div class="form-group">
                    <div class="input-group col-md-12">
                       <span class="input-group-addon">سیستم مجهز به گزارش سازاست</span>
                            <select  data-width="75%" id="ddCreatReport10" class="form-control">
                                 <option value ="0">خیر</option>
                                 <option value="1">بلی</option>
                            </select>    
                    </div>
               </div>
                      <div class="form-group">
                    <div class="input-group col-md-12 ">
                       <span class="input-group-addon">مستندات راهنمای کاربری نرم افزار</span>
                            <select data-width="75%" id="ddDoc10" class="form-control">
                                <option value="0">ندارد</option>
                                <option value="1">دارد</option>
                            </select>    
                    </div>
               </div>
                      <div class="form-group">
                    <div class="input-group col-md-12">
                       <span class="input-group-addon">خریدار</span>
                        <select  data-width="75%" id="ddBuy10"  class="form-control">
                            <option value="0">وزارت خانه</option>
                            <option value="1">علوم پزشکی</option>
                        </select>    
                    </div>
               </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                     <div class="input-group col-md-12">
                         <span class="input-group-addon">تعداد کاربران مجاز</span>
                         <input type="text" class="form-control"id="UserCount" />
                     </div>
                 </div>
                    <div class="form-group">
                      <div class="input-group col-md-12">
                           <span class="input-group-addon">محل قرار گرفتن سرور نرم افزار</span>
                            <input type="text" class="form-control" id="ServerLocation"/>
                         
                          </div>
                     </div>
                    <div class="form-group">
                      <div class="input-group col-md-12">
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

                   
                    </div>
                </div>

                <div class="modal-footer">
                    <span id="lblMessage"></span>
                    <button type="button" id="btnAdd1" class="btn btn-success" data-toggle="modal" data-target="#myModal1"  data-target=".bs-example-modal-lg"><i class="fa fa-plus"></i>&nbsp;اطلاعات مربوط به ارتقاء</button>
                      <button type="button" id="btnEdit" class="btn btn-success">ویرایش اطلاعات</button>
                    <button type="button" id="btnSave" class="btn btn-success">ذخیره اطلاعات</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">انصراف</button>
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
                    <span id="lblMessage"></span>
                    <button type="button" class="btn btn-default" data-dismiss="modal">انصراف</button>
                    <button type="button" id="btnSave1" class="btn btn-success">ذخیره اطلاعات</button>
                    

                </div>
            </div>
        </div>
    </div>
</asp:Content>
