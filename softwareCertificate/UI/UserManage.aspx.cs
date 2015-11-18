using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using softwareCertificate.POL;
using softwareCertificate.BLL;
using Newtonsoft.Json;
using System.Web.Security;

namespace softwareCertificate.UI
{
    
    public partial class UserManage : System.Web.UI.Page
    {
         protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (System.Web.HttpContext.Current.Session["admin"].ToString() != "True")
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
            }
            catch(Exception)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
         }
        [WebMethod(EnableSession = true)]
        public static string FillCmbVahedAddUser()
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.FillCmbVahedAddSoftware());
        }

        [WebMethod(EnableSession = true)]
        public static string FillCmbZoneAddUser()
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.FillCmbZoneAddSoftware());
        }
        [WebMethod(EnableSession = true)]
        public static string UserReqSe(int firstRow)
        {
            UserReqBLL urb = new UserReqBLL();
            return JsonConvert.SerializeObject(urb.UserReqSearch(firstRow));
        }
        
        [WebMethod(EnableSession = true)]
        public static string VahedUserReq(Int16 userCode)
        {
            UserReqBLL urb = new UserReqBLL();
            return JsonConvert.SerializeObject(urb.VahedUserReqSearch(userCode));
        }

        [WebMethod(EnableSession = true)]
        public static string UserReqSeByUserCode(Int16 userCode)
        {
            UserReqBLL urb = new UserReqBLL();
            return JsonConvert.SerializeObject(urb.UserReqSeByUserCode(userCode));
        }
        [WebMethod]
        public static string creatReqUser(userinfo rn, List<VahedUser> rgr)
        {
           UserReqBLL fb = new UserReqBLL();
           return JsonConvert.SerializeObject(fb.creatReqUser(rn,rgr));
        }
         [WebMethod]
        public static string UpdateReqUser(userinfo rn)
        {
           UserReqBLL fb = new UserReqBLL();
           return JsonConvert.SerializeObject(fb.UpdateReqUser(rn));
        }
        
        [WebMethod]
         public static string UpdateVahedUser(List<VahedUser> rgr,Int16 userCode)
        {
           UserReqBLL fb = new UserReqBLL();
           return JsonConvert.SerializeObject(fb.UpdateVahedUser(rgr, userCode));
        }
        
         [WebMethod]
        public static string SearchInTable(string Name, string UserName, int firstRow)
        {
            UserReqBLL fb = new UserReqBLL();
            return JsonConvert.SerializeObject(fb.SearchInTable(Name, UserName, firstRow));
        }

         [WebMethod]
         public static string deleteUser(Int16 userCode)
         {
             UserReqBLL fb = new UserReqBLL();
             return JsonConvert.SerializeObject(fb.deleteUser(userCode));
         }
          [WebMethod]
         public static string deleteVahedUser(Int16 id)
         {
             UserReqBLL fb = new UserReqBLL();
             return JsonConvert.SerializeObject(fb.deleteVahedUser(id));
         }
        
          [WebMethod]
          public static string checkUserName(string userName)
         {
             UserReqBLL fb = new UserReqBLL();
             return JsonConvert.SerializeObject(fb.checkUserName(userName));
         }

          [WebMethod]
          public static string ChangePass(string oldPass, string newPass)
          {
              UserReqBLL fb = new UserReqBLL();
              return JsonConvert.SerializeObject(fb.changePass(oldPass, newPass));
          }
        
    }
}