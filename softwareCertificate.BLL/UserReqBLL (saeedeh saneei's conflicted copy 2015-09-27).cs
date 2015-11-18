using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using softwareCertificate.POL;
using softwareCertificate.DALL;
using System.Data;
using System.Data.Linq;


namespace softwareCertificate.BLL
{

   public class UserReqBLL
    {
       softwareCertificateDBDataContext db = new softwareCertificateDBDataContext();
       public Results<DataTable> UserReqSearch()
       {

           DataTable list = new DataTable();
           Results<DataTable> result = new Results<DataTable>();
           try
           {

               helperSearch sHelper = new helperSearch();
               list = sHelper.searchUser();


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

       public object creatReqUser(userinfo rn, List<VahedUser> rgr)
       {
           Results<string> result = new Results<string>();
           
            try
            {
                HelperData h = new HelperData();
                db.Connection.Open();
                using (db.Transaction = db.Connection.BeginTransaction()) 
                rn.pass = new CustomMembershipProvider().EncryptPassword(rn.pass);
                rn.deleted = false;
                
                Int16 t = h.AddUserInfo(rn);
                if (t!=0)
                {
                    bool s = h.AddVahedUser(rgr, t);
                    if (s)
                    {
                        db.Transaction.Commit();
                        result.IsSuccessfull = true;
                    }
                }
               
            }
            catch (Exception error)
            {
                db.Transaction.Rollback();
                result.IsSuccessfull = false;
                result.Message = error.Message;
            }
            return result;
        }


       public object SearchInTable(string Name, string UserName)
       {
           DataTable list = new DataTable();
            Results<DataTable> result = new Results<DataTable>();
            try
            {
                
                helperSearch sHelper = new helperSearch();
                list = sHelper.searchUser(Name, UserName);


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

       public object UserReqSeByUserCode(Int16 userCode)
       {
           DataTable list = new DataTable();
           Results<DataTable> result = new Results<DataTable>();
           try
           {

               helperSearch sHelper = new helperSearch();
               list = sHelper.searchUser(userCode);


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

       public object UpdateReqUser(userinfo rn)
       {
           Results<string> result = new Results<string>();
           try
           {
               HelperData h = new HelperData();
               rn.pass = new CustomMembershipProvider().EncryptPassword(rn.pass);
               int t = h.EditUserInfo(rn);
               if (t == 1)
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


       public object deleteUser(short userCode)
       {
           Results<DataTable> result = new Results<DataTable>();
           try
           {

               HelperData sHelper = new HelperData();
               int list = sHelper.DeleteUserInfo(userCode);


               if (list == 1)
               {
                   result.Message = "";
                   result.IsSuccessfull = true;
                   sHelper.DeleteVahedUser(userCode);
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

       public object VahedUserReqSearch(Int16 userCode)
       {
           DataTable list = new DataTable();
           Results<DataTable> result = new Results<DataTable>();
           try
           {

               helperSearch sHelper = new helperSearch();
               list = sHelper.searchVahedUser(userCode);


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

       public object deleteVahedUser(Int16 id)
       {
           Results<DataTable> result = new Results<DataTable>();
           try
           {

               HelperData sHelper = new HelperData();
               int list = sHelper.DeleteVahedUser(id);


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

       public object checkUserName(string userName)
       {

           Results<DataTable> result = new Results<DataTable>();
           try
           {

               helperSearch h = new helperSearch();
               int list = h.checkUniqUser(userName);


               if (list == 1)
               {
                   result.Message = "";
                   result.IsSuccessfull = true;
               }
               else if(list == 2)
               {
                   result.Message = "نام کاربری تکراری است.";
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
