using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace softwareCertificate.UI
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            else
            {



                string menu = "<ul class='menu nav nav-pills nav-stacked'>";
                if (System.Web.HttpContext.Current.Session["admin"].ToString() == "True")
                    menu += "<li class='has-sub '><a style='text-shadow: 0px 1px 1px rgba(0, 0, 0, 0.35);'>" +
                   "<span style='border-color: rgba(0, 0, 0, 0.35);'>اطلاعات پایه</span><span style='border-color: rgba(0, 0, 0, 0.35);' class='holder'></span></a>";
                 menu += "<ul>";
                if (System.Web.HttpContext.Current.Session["admin"].ToString() == "True")
                    menu += " <li><a href='VahedManage.aspx'><span>واحد های سازمانی</span></a></li>";
                if (System.Web.HttpContext.Current.Session["admin"].ToString() == "True")
                    menu += " <li><a href='ZoneManage.aspx'><span>حوزه های سازمانی</span></a></li>";

                menu += "</ul></li><li><a href='AddSoftware.aspx'><span>اطلاعات نرم افزارها</span></a></li><li><a href='SoftwareManage.aspx'><span>گزارشات ومدیریت اطلاعات نرم افزار</span></a></li>";
                if (System.Web.HttpContext.Current.Session["admin"].ToString() == "True")
                    menu += "<li><a href='UserManage.aspx'><span>کاربران</span></a></li>";
                menu += " </ul></li>";
           
                menu += "</ul>";
                cssmenu.InnerHtml = menu;
                txtUsername.InnerText = System.Web.HttpContext.Current.Session["Name"].ToString();
            }
        }
    }
}