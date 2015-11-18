using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using softwareCertificate.BLL;
using softwareCertificate.POL;
using Newtonsoft.Json;
using System.Web.Services;

namespace softwareCertificate.UI
{
    public partial class SoftwareManage : System.Web.UI.Page
    {


        [WebMethod(EnableSession = true)]
        public static string FillCmbVahedAddSoftware()
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.FillCmbVahedAddSoftware());
        }
        [WebMethod(EnableSession = true)]
        public static string SoftwareReqSe(int firstRow)
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.SearchReqSoftware(firstRow));
        }
        [WebMethod(EnableSession = true)]
        public static string SoftwareReqSeBySoft(Int16 softwareCode)
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.SoftwareReqSeBySoft(softwareCode));
        }
       
       [WebMethod(EnableSession = true)]
        public static string UpgradeReqSeBySoft(Int16 softwareCode)
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.UpgradeReqSeBySoft(softwareCode));
        }

        [WebMethod(EnableSession = true)]
        public static string creatSoftReq(softwareInfo rn)
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.creatSoftReq(rn));
        }
         [WebMethod(EnableSession = true)]
        public static string updateSoftReq(softwareInfo rn)
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.updateSoftReq(rn));
        }
        
        [WebMethod(EnableSession = true)]
        public static string creatSoftUpgradeReq(softwareInfo rn,upgrade up)
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.creatSoftReq(rn,up));
        }

        [WebMethod]
        public static string deleteSoftware(Int16 softwareCode)
        {
            AddSoftwareBLL fb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(fb.deleteSoftware(softwareCode));
        }
        
       
        [WebMethod(EnableSession = true)]
        public static string SofSearchInTable(string SoftwareName,string CompanyName,string VahedValue,string ZoneValue,string StartDate,string EndDate,int firstRow)
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.SofSearchInTable(SoftwareName, CompanyName, VahedValue, ZoneValue, StartDate, EndDate, firstRow));
        }

        [WebMethod(EnableSession = true)]
        public static string updateUpgradeReq(upgrade rn)
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.updateUpgradeReq(rn));
        }
        [WebMethod]
        public static string logOut()
        {
            System.Web.HttpContext.Current.Session["admin"] = false;
            System.Web.HttpContext.Current.Session["userCode"] = null;
            System.Web.HttpContext.Current.Session["Name"] = null;
            System.Web.HttpContext.Current.Session.Clear();
            return "";
        }
    }
}