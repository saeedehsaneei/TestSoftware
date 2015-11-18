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
   public class ZoneReqBLL
    {
       public Results<DataTable> ZoneReqSearch(int firstRow)
       {

           DataTable list = new DataTable();
           Results<DataTable> result = new Results<DataTable>();
           try
           {

               helperSearch sHelper = new helperSearch();
               list = sHelper.searchZone(firstRow, firstRow+6 -1);


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

       public object creatReqZone(zoneInfo zi)
       {
           Results<string> result = new Results<string>();
           try
           {
              HelperData h = new HelperData();
              int t= h.AddZone(zi);
               if (t==1)
               {
                   result.IsSuccessfull = true;
               }
               else if (t == 0)
               {
                   result.Message = "فیلدی با این مشخصات قبلا ثبت شده است.";
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
               list = sHelper.searchZone(Name, firstRow, firstRow + 6 - 1);


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

       public object ZoneReqSearch1(short zoneCode)
       {

           DataTable list = new DataTable();
           Results<DataTable> result = new Results<DataTable>();
           try
           {

               helperSearch sHelper = new helperSearch();
               list = sHelper.searchZone1(zoneCode);


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

       public object DeleteZone(short zoneCode)
       {
           Results<DataTable> result = new Results<DataTable>();
           try
           {

               HelperData sHelper = new HelperData();
               int i = sHelper.DeleteZoneInfo(zoneCode);
               if (i == 1)
               {
                   result.Message = "";
                   result.IsSuccessfull = true;
               }
               else
               {
                   result.Message = "";
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
