using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using softwareCertificate.BLL;
using softwareCertificate.POL;
using Newtonsoft.Json;
using System.Web;
using System.Web.Security;

namespace softwareCertificate.UI
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try { 
            if (System.Web.HttpContext.Current.Session["admin"].ToString() != "True")
            {
                FormsAuthentication.RedirectToLoginPage();
            }
                }
            catch (Exception)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }
        [WebMethod]
        public static string ZoneReqSe(int firstRow)


        {
            ZoneReqBLL fb = new ZoneReqBLL();
            return JsonConvert.SerializeObject(fb.ZoneReqSearch(firstRow));
        }
        
           [WebMethod]
        public static string DeleteZone(Int16 zoneCode)


        {
            ZoneReqBLL fb = new ZoneReqBLL();
            return JsonConvert.SerializeObject(fb.DeleteZone(zoneCode));
        }

        [WebMethod]
        public static string ZoneSearchById(Int16 zoneCode)
        {
            ZoneReqBLL fb = new ZoneReqBLL();
            return JsonConvert.SerializeObject(fb.ZoneReqSearch1(zoneCode));
        }

         [WebMethod]
        public static string creatReqZone(zoneInfo rn)
        {
            ZoneReqBLL nb = new ZoneReqBLL();
            return JsonConvert.SerializeObject(nb.creatReqZone(rn));
        }
         [WebMethod]
         public static string SearchInTable(string Name, int firstRow)
         {
             ZoneReqBLL nb = new ZoneReqBLL();
             return JsonConvert.SerializeObject(nb.SearchInTable(Name, firstRow));
         }
    }
}