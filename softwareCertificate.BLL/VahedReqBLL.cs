using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using softwareCertificate.POL;
using softwareCertificate.DALL;
using System.Data;

namespace softwareCertificate.BLL
{
    public class VahedReqBLL
    {
        public Results<DataTable> VahedReqSearch(int firstRow)
        {

            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {
           
               helperSearch sHelper = new helperSearch();
               list = sHelper.searchVahed(firstRow, firstRow +6 -1);


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

        public object creatReqVahed(vahedInfo vi)
        {
            Results<string> result = new Results<string>();
            try
            {
                HelperData h = new HelperData();
                int t = h.AddVahed(vi);
                if (t==1)
                {
                    result.IsSuccessfull = true;
                }
                else if (t == 0)
                {
                    result.Message = "خطا!  فیلدی با این مشخصات قبلا ثبت شده است.";
                }
            }
            catch (Exception error)
            {
                result.IsSuccessfull = false;
                result.Message = error.Message;
            }
            return result;
        }



        public object SearchInTable(string Name, int firstRow)
        {
            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {

                helperSearch sHelper = new helperSearch();
                list = sHelper.searchVahed(Name, firstRow, firstRow +6 -1);


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

        public object VahedReqSearch1(short vahedCode)
        {
            DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {

                helperSearch sHelper = new helperSearch();
                list = sHelper.searchVahed1(vahedCode);


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

        public object deleteVahed(short vahedCode)
        {
           
            Results<DataTable> result = new Results<DataTable>();
            try
            {

                HelperData sHelper = new HelperData();
                int list = sHelper.DeleteVahedInfo(vahedCode);


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
