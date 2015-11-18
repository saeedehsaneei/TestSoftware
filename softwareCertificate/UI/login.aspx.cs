using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Web.UI.WebControls;
using softwareCertificate.POL;
using softwareCertificate.BLL;
using System.Web.Security;
using Newtonsoft.Json;
using System.Globalization;

namespace softwareCertificate.UI
{
    public partial class login : System.Web.UI.Page
    {
        [WebMethod(EnableSession = true)]
        public static string UserLogins(string username, string password)
        {
            Results<string> result = new Results<string>();
            if (Membership.ValidateUser(username, password))
            {
                result.IsSuccessfull = true;
                result.Value = "../UI/SoftwareManage.aspx";
                return JsonConvert.SerializeObject(result);
            }
            else
            {
                result.IsSuccessfull = false;
                result.Value = "نام کاربری یا کلمه عبور اشتباه است.";
              
                return JsonConvert.SerializeObject(result);
            }
        }
       
        [WebMethod(EnableSession = true)]
        public static string checkUserEmail(string user, string Email)
        {
            loginBLL lb = new loginBLL();
            return JsonConvert.SerializeObject(lb.searchUserEmail(user, Email));
        }
        [WebMethod]
        public static string sendEmail(string email, string user)
        {
            loginBLL lb = new loginBLL();
            return JsonConvert.SerializeObject(lb.sendEmail(user, email));
        }
       
        [WebMethod]
        public static string changPass (string userName)
        {
            loginBLL lb = new loginBLL();
            return JsonConvert.SerializeObject(lb.changPass(userName));
        }
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
        protected void Page_Load(object sender, EventArgs e)
        {
            spanTime.InnerText = "امروز : " + setDate();
        }

       
    }
}