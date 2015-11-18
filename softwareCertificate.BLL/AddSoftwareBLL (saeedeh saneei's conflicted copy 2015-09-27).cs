using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using softwareCertificate.DALL;
using softwareCertificate.POL;
using System.Data;
using System.Globalization;

namespace softwareCertificate.BLL
{
    public class AddSoftwareBLL
    {
        public Results<DataTable> FillCmbVahedAddSoftware()
        {

            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {
                helperSearch sHelper = new helperSearch();
                list = sHelper.fillCombo("vahedInfo", "vahedCode", "vahedName");
                if (list.Rows.Count == 0)
                {
                    result.Message = "";
                    result.IsSuccessfull = false;
                }
                else
                {
                    result.Value = list;
                    result.IsSuccessfull = true;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }


        public object FillCmbZoneAddSoftware()
        {
            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {
                helperSearch sHelper = new helperSearch();
                list = sHelper.fillCombo("zoneInfo", "zoneCode", "zoneName");
                if (list.Rows.Count == 0)
                {
                    result.Message = "";
                    result.IsSuccessfull = false;
                }
                else
                {
                    result.Value = list;
                    result.IsSuccessfull = true;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }
        public object  FillCmbLanguageAddSoftware()
        {
            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {
                helperSearch sHelper = new helperSearch();
                list = sHelper.fillCombo("programLanguage", "programLangCode", "languageName");
                if (list.Rows.Count == 0)
                {
                    result.Message = "";
                    result.IsSuccessfull = false;
                }
                else
                {
                    result.Value = list;
                    result.IsSuccessfull = true;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }
        public object FillCmbMemariAddSoftware()
        {
            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {
                helperSearch sHelper = new helperSearch();
                list = sHelper.fillCombo("memariSystem", "memariCode", "memariName");
                if (list.Rows.Count == 0)
                {
                    result.Message = "";
                    result.IsSuccessfull = false;
                }
                else
                {
                    result.Value = list;
                    result.IsSuccessfull = true;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }
        public object FillCmbDbAddSoftware()
        {
            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {
                helperSearch sHelper = new helperSearch();
                list = sHelper.fillCombo("DB", "dbCode", "name");
                if (list.Rows.Count == 0)
                {
                    result.Message = "";
                    result.IsSuccessfull = false;
                }
                else
                {
                    result.Value = list;
                    result.IsSuccessfull = true;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }






        public Results<DataTable> SearchReqSoftware(Int16 userCode)
        {

            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {

                helperSearch sHelper = new helperSearch();
                list = sHelper.searchSoftware1(Convert.ToInt16(System.Web.HttpContext.Current.Session["userCode"]));


                if (list.Rows.Count == 0)
                {
                    result.Message = "";
                    result.IsSuccessfull = false;
                }
                else
                {
                    result.Value = list;
                    result.IsSuccessfull = true;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }

        public Results<string> creatSoftReq(softwareInfo rn)
        {
            Results<string> result = new Results<string>();
            try
            {
                HelperData h = new HelperData();
                rn.userCode = Convert.ToInt16(System.Web.HttpContext.Current.Session["userCode"]);
                rn.deleted = false;
                Int16 t = h.AddSoftwareInfo(rn);
                if (t!= 0)
                {
                    result.IsSuccessfull = true;
                    result.Value = rn.softwareCode.ToString();
                }
            }
            catch (Exception error)
            {
                result.IsSuccessfull = false;
                result.Message = error.Message;
            }
            return result;
        }

        public Results<string> creatSoftReq(softwareInfo rn,upgrade up)
        {
            Results<string> result = new Results<string>();
            try
            {
                HelperData h = new HelperData();
                rn.userCode = Convert.ToInt16(System.Web.HttpContext.Current.Session["userCode"]);
                rn.deleted = false;
                up.deleted = false;
                Int16 t = h.AddSoftwareInfo(rn);
                if (t != 0)
                {
                    result.IsSuccessfull = true;
                    up.softwareCode = rn.softwareCode;
                    h.AddUpgrade(up);

                }
            }
            catch (Exception error)
            {
                result.IsSuccessfull = false;
                result.Message = error.Message;
            }
            return result;
        }

        public object SofSearchInTable(string SoftwareName, string CompanyName, string VahedValue, string ZoneValue,string StartDate,string EndDate)
        {
             DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {
                Int16 vahedCode = Convert.ToInt16(VahedValue);
                Int16 zoneCode = Convert.ToInt16(ZoneValue);
                helperSearch sHelper = new helperSearch();
                list = sHelper.searchSoftware(SoftwareName, CompanyName, vahedCode, zoneCode, StartDate, EndDate);


                if (list.Rows.Count == 0)
                {
                    result.Message = "";
                    result.IsSuccessfull = false;
                }
                else
                {
                    result.Value = list;
                    result.IsSuccessfull = true;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }

        public object createUpgrade(upgrade rn)
        {
            Results<string> result = new Results<string>();
            try
            {
                HelperData h = new HelperData();
              
                
                rn.deleted = false;
                bool t = h.AddUpgrade(rn);
                if (t )
                {
                    result.IsSuccessfull = true;
                }
            }
            catch (Exception error)
            {
                result.IsSuccessfull = false;
                result.Message = error.Message;
            }
            return result;
        }



        public object SoftwareReqSeBySoft(Int16 softwareCode)
        {
            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {

                helperSearch sHelper = new helperSearch();
                list = sHelper.searchSoftware2(softwareCode);


                if (list.Rows.Count == 0)
                {
                    result.Message = "";
                    result.IsSuccessfull = false;
                }
                else
                {
                    result.Value = list;
                    result.IsSuccessfull = true;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }

        public object updateSoftReq(softwareInfo rn)
        {
            Results<string> result = new Results<string>();
            try
            {
                HelperData h = new HelperData();
                rn.deleted = false;
                rn.userCode = Convert.ToInt16(System.Web.HttpContext.Current.Session["userCode"]);
                
                int t = h.EditSoftwareInfo(rn);
                if (t != 0)
                {
                    result.IsSuccessfull = true;
                  //  result.Value = rn.softwareCode.ToString();
                }
            }
            catch (Exception error)
            {
                result.IsSuccessfull = false;
                result.Message = error.Message;
            }
            return result;
        }

        public object deleteSoftware(short softwareCode)
        {

            Results<DataTable> result = new Results<DataTable>();
            try
            {

                HelperData sHelper = new HelperData();
                int list = sHelper.DeleteSoftwareInfo(softwareCode);


                if (list == 1)
                {
                    result.Message = "";
                    result.IsSuccessfull = true;
                }
                else
                {

                    result.IsSuccessfull = false;
                }
                return result;
            }
            catch
            {
                return result;
            }
        }
    }
    
    
}
