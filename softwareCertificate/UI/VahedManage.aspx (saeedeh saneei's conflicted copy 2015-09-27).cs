using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using softwareCertificate.BLL;
using softwareCertificate.POL;
using Newtonsoft.Json;

namespace softwareCertificate.UI
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        [WebMethod]
        public static string VahedReqSe()
        {
            VahedReqBLL fb = new VahedReqBLL();
            return JsonConvert.SerializeObject(fb.VahedReqSearch());
        }
        [WebMethod]
        public static string VahedReqSeByID(Int16 vahedCode)
        {
            VahedReqBLL fb = new VahedReqBLL();
            return JsonConvert.SerializeObject(fb.VahedReqSearch1(vahedCode));
        }
        [WebMethod]
        public static string deleteVahed(Int16 vahedCode)
        {
            VahedReqBLL fb = new VahedReqBLL();
            return JsonConvert.SerializeObject(fb.deleteVahed(vahedCode));
        }

        [WebMethod]
        public static string creatReqVahed(vahedInfo rn)
        {
            VahedReqBLL fb = new VahedReqBLL();
            return JsonConvert.SerializeObject(fb.creatReqVahed(rn));
        }
        [WebMethod]
        public static string SearchInTable(string Name)
        {
           VahedReqBLL nb = new VahedReqBLL();
            return JsonConvert.SerializeObject(nb.SearchInTable(Name));
        }
    }
}