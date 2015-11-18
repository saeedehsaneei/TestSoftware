using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Globalization;

namespace softwareCertificate.UI
{
    public partial class Main : System.Web.UI.MasterPage
    {
        public string setDate()
        {
            PersianCalendar pdate = new PersianCalendar();
            DateTime nT = new DateTime();
            nT = DateTime.Now;
            string mounth = "";
            if (pdate.GetMonth(nT).ToString().Length == 1)
                mounth = "0" + pdate.GetMonth(nT).ToString();
            else
                mounth = pdate.GetMonth(nT).ToString();
            string day = "";
            if (pdate.GetDayOfMonth(nT).ToString().Length == 1)
                day = "0" + pdate.GetDayOfMonth(nT).ToString();
            else
                day = pdate.GetDayOfMonth(nT).ToString();
            string date = String.Format("{0}/{1}/{2}", pdate.GetYear(nT), mounth, day);
            return date;
        }
        public string setTime()
        {
            PersianCalendar pdate = new PersianCalendar();
            DateTime nT = new DateTime();
            nT = DateTime.Now;
            string time = "";
            time = pdate.GetHour(nT) + ":" + pdate.GetMinute(nT);
            return time;
   
        }
        
       
        protected void Page_Load(object sender, EventArgs e)
        {
            
            

            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            else
            {
                try { 
               
                if (System.Web.HttpContext.Current.Session["admin"].ToString() != null)
                {


                    string menu = "<ul class='menu nav nav-pills nav-stacked'>";
                    if (System.Web.HttpContext.Current.Session["admin"].ToString() == "True")
                        menu += "<li class='has-sub '><a style='text-shadow: 0px 1px 1px rgba(0, 0, 0, 0.35);'>" +
                       "<span style='border-color: rgba(0, 0, 0, 0.35);'><i class='fa fa-pencil-square-o'></i>&nbsp;اطلاعات پایه</span><span style='border-color: rgba(0, 0, 0, 0.35);' class='holder'></span></a>";
                    menu += "<ul>";
                    if (System.Web.HttpContext.Current.Session["admin"].ToString() == "True")
                        menu += " <li><a href='VahedManage.aspx'><span><i class='fa fa-building-o'></i>&nbsp;واحد های سازمانی</span></a></li>";
                    if (System.Web.HttpContext.Current.Session["admin"].ToString() == "True")
                        menu += " <li><a href='ZoneManage.aspx'><span><i class='fa fa-building'></i>&nbsp;حوزه های سازمانی</span></a></li>";

                    menu += "</ul></li><li><a href='AddSoftware.aspx'><span><i class='fa fa-desktop'></i>&nbsp;اطلاعات نرم افزارها</span></a></li><li><a href='SoftwareManage.aspx'><span><i class='fa fa-area-chart'></i>&nbsp;گزارشات ومدیریت اطلاعات نرم افزار</span></a></li>";
                    if (System.Web.HttpContext.Current.Session["admin"].ToString() == "True")
                        menu += "<li><a href='UserManage.aspx'><span><i class='fa fa-users'></i>&nbsp;کاربران</span></a></li>";
                    menu += " </ul></li>";

                    menu += "</ul>";
                    cssmenu.InnerHtml = menu;
                   txtUsername.InnerText = System.Web.HttpContext.Current.Session["Name"].ToString();
                   txtDate.InnerHtml = setDate();
                 //  txthour.InnerHtml = setTime();
                }
                }
                catch(Exception)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
            }
        }
       
        //protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        //{
        //    System.Web.HttpContext.Current.Session["Name"] = null;
        //    System.Web.HttpContext.Current.Session["admin"] = null;
        //    System.Web.HttpContext.Current.Session["userCode"] = null;
        //    Response.Redirect("login.aspx");
        //}
    }
}