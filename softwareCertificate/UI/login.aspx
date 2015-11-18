﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="softwareCertificate.UI.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/css/bootstrap.css" rel="stylesheet" />
    <link href="../Content/css/bootstrap-rtl.css" rel="stylesheet" />
    <link href="../Content/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Content/fonts/B_Nazanin_Bold/stylesheet.css" rel="stylesheet" />
    <link href="../Content/css/login.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap-rtl.js"></script>
    <script src="../Scripts/jquery.validate.min.js"></script>
    <script src="../Scripts/messages_fa.js"></script>
    <%---------------------------------------------------------------------------------------------------------------------------------------------------%>
   <script>
       $(document).ready(function () {
           $("#BtnLogin").click(function () {
               LoginFunc();
           })
           $('input').keydown(function (e) {
               if (e.keyCode == 13) {
                   $('#BtnLogin').focus();
               }
           })
           function LoginFunc() {
               var username1 = $("#txtUsername").val();
               var password1 = $("#txtPass").val();
               if (username1 == "" || password1 == "")
                   $('#lblMessage').text('لطفا نام کاربری و کلمه عبور را وارد کنید');
               else {
                   $.ajax({
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: 'Login.aspx/UserLogins',
                       data: JSON.stringify({ username: username1, password: password1 }),
                       dataType: "json",
                       success: function (response) {
                           var result = $.parseJSON(response.d);
                           if (result.IsSuccessfull == true) {
                               window.location.href = result.Value;
                           }
                           else {
                               $(' #msglogin', $('.login-form')).text(result.Value);
                               $('.alert-danger', $('.login-form')).show();
                               $('#lblMessage').text('نام کاربری یا کلمه عبور اشتباه است.');
                               $("#txtUsername").val("");
                               $("#txtPass").val("");
                           }
                           //setTimeout(function () {
                           //    $('#loading').html('<img src="Images/noImage.png>');
                           //}, 500);
                       },
                       failure: function () {
                           $(' #msglogin', $('.login-form')).text('عملیات ناموفق بود. لطفا دوباره تلاش کنید');
                           $('.alert-danger', $('.login-form')).show();
                           $("#MessegeLogin").val();
                       }
                   });
               }
           }

           function changPass(user) {
               var userName = user;
               $.ajax({
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   url: 'Login.aspx/changPass',
                   data: JSON.stringify({ userName: userName}),
                   dataType: "json",
                   success: function (response) {
                       var result = $.parseJSON(response.d);
                       if (result.IsSuccessfull == true) {
                          
                       }
                       else {
                           alert("اشکال در خواندن اطلاعات");
                       }
                       
                   },
                   failure: function () {
                       alert("اشکال در خواندن اطلاعات");
                   }
               });
           }

           $("#BtnSendEmail").click(function () {
               
               try {
                   var flag = 0;
                   var user = $("#txtUsernameForget").val();
                   var email = $("#txtEmail").val();
                   if (user == "" || email == "")
                       $('#lblMessage').text('لطفا نام کاربری و آدرس ایمیل را وارد کنید');
                   else {
                       $.ajax({
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: 'login.aspx/checkUserEmail',
                           data: JSON.stringify({ user: user, Email: email }),
                           dataType: "json",
                           success: function (response) {
                               var result = $.parseJSON(response.d);
                               if (result.IsSuccessfull == true) {
                                   flag = result.value;
                                   
                               }
                               else {
                                   flag = 0;
                                   alert(result.Message);
                               }
                           }
                       });
                       //send Email--------------------------
                      
                       if (flag != 0) {
                           $.ajax({
                               type: "POST",
                               contentType: "application/json; charset=utf-8",
                               url: 'login.aspx/sendEmail',
                               data: JSON.stringify({ email: email, user: user }),
                               dataType: "json",
                               success: function (response) {
                                   var result = $.parseJSON(response.d);
                                   if (result.IsSuccessfull == true) {
                                       alert("رمز عبور جدید به ایمیل شما ارسال شد.");
                                       changPass(user);
                                   }
                                   else {

                                       alert(result.Message);
                                   }
                               }
                           });
                       }
                   }
               }
               catch (e) {
                   alert("ارتباط با سرور برقرار نشد، مجددا تلاش کنید");
               }

           });


           $("#txtUsername").focusin(function () {
               $('#lblMessage').text("");
           });
           $("#txtPass").focusin(function () {
               $('#lblMessage').text("");
           });

          

       });
    </script>
    <%----------------------------------------------------------------------------------------------------------------------------------------------------%>

</head>
<body>
    
     <div class="line-blue"></div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <div class="logo-login"></div>
            </div>
            <div class="col-md-6">
                <br />
                <div class="date-box pull-left">
                    <div class="item-link-top pull-left"><i class="fa fa-question green"></i></div>
                    <div class="date-time"><span id="spanTime" runat="server"><i class="fa fa-calendar-o"></i>&nbsp;&nbsp;</span></div>
                </div>
            </div>
        </div>
        <div class="row login-container">
            <div class="back-box">
                <div class="col-md-4">
                </div>
                <div class="col-md-4 login-box">
                    <h2><i class="fa fa-sign-in"></i>&nbsp;ورود به سیـســتم</h2>
                    <div class="line-blue"></div>
                    <form class="form-horizontal login-form">
                        <div class="toggle">
                            <div class="btn forget-password" id="btnForget">
                                .......&nbsp;رمـز عـبـور خود را فراموش کـرده ام؟&nbsp;.......
                            </div>
                        </div>
                        <div class="form">
                            <div class="input-icon">
                                <input type="text" class="form-control user-pass" id="txtUsername" placeholder="نـام کـاربـری" />
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="input-icon">
                                <input type="password" class="form-control placeholder-no-fix user-pass" id="txtPass" placeholder="رمـز عـبـور" />
                                <i class="fa fa-lock"></i>
                            </div>
                            <label id="lblMessage" style="color: red; font-size: 16px" runat="server"></label>
                            <input id="BtnLogin" type="button" value="ورود به سیستم" class="btn bg-info btn-block" />

                            <div class="alert alert-danger hidden" style="margin: 3px 0 !important;">
                                <button class="close" data-close="alert"></button>
                                <span id="msglogin"></span>
                            </div>
                            <div class="clearfix"></div>



                        </div>
                        <div class="form">
                            <h2>نام کاربری و آدرس ایمیل خود را جهت ارسال رمز عبور جدید وارد نمایید</h2>
                            <div class="input-icon">
                                <input type="text" class="form-control user-pass" id="txtUsernameForget" placeholder="نـام کـاربـری" />
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="input-icon">
                                <input type="email" class="form-control placeholder-no-fix user-pass" id="txtEmail" placeholder="ادرس ایمیل" />
                                <i class="fa fa-envelope"></i>
                            </div>
                            <input id="BtnSendEmail" type="button" value="ارسال ایمیل" class="btn bg-info btn-block" />
                        </div>
                    </form>
                </div>
              <div class="col-md-4">
                </div>
            </div>
            <div class="back-box-bottom"></div>
        </div>
        <div class="row">
            <div class="col-md-6 kmu-footer">
                <span class="logo-kmu-footer">
                    <img src="../Content/images/logo-kmu.ac.png" style="display: inline-block; background-position: right;" />
                    کلیه حقوق این سامانه متعلق به مدیریت آمار و فناوری اطلاعات دانشگاه علوم پزشکی کرمان می باشد.</span>
            </div>
            <div class="col-md-6">
                <div class="copy-right">
                    <a href="http://kmu.ac.ir/">Copyright  &copy; 2015
                <script>new Date().getFullYear() > 2015 && document.write("-" + new Date().getFullYear());</script>
                        ,
                 kmu.ac.ir, All rights reserved.  </a>
                    <br />
                    <a href="http://padidar.com/">power by padidar co,
                    </a>
                </div>
            </div>
        </div>

    </div>
    <script src="../Content/js/login.js"></script>

</body>
</html>

