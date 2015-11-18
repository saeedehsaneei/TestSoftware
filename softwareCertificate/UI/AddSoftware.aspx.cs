using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Web.UI.WebControls;
using softwareCertificate.BLL;
using softwareCertificate.POL;
using Newtonsoft.Json;

namespace softwareCertificate.UI
{
    public partial class AddSoftware : System.Web.UI.Page
    {
        [WebMethod(EnableSession = true)]
        public static string FillCmbVahedAddSoftware()
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.FillCmbVahedAddSoftware());
        }

        [WebMethod(EnableSession = true)]
        public static string FillCmbZoneAddSoftware()
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.FillCmbZoneAddSoftware());
        }
        [WebMethod(EnableSession = true)]
        public static string FillCmbLanguageAddSoftware()
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.FillCmbLanguageAddSoftware());
        }
        [WebMethod(EnableSession = true)]
        public static string FillCmbMemariAddSoftware()
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.FillCmbMemariAddSoftware());
        }
        [WebMethod(EnableSession = true)]
        public static string FillCmbDbAddSoftware()
        {
            AddSoftwareBLL asb = new AddSoftwareBLL();
            return JsonConvert.SerializeObject(asb.FillCmbDbAddSoftware());
        }
    }
}
