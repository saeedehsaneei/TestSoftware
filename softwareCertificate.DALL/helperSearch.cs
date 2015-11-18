using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using softwareCertificate.POL;
using System.Security;

namespace softwareCertificate.DALL
{
  public  class helperSearch
    {
        dataAccess dA = new dataAccess();
        softwareCertificateDBDataContext db=new softwareCertificateDBDataContext ();
        public DataTable searchSoftware(int firstRow,int lastRow ,string name = "", string nameSherkat = "", Int16 vahedSAzmaniCode = 0, Int16 zoneCode = 0, string StartDate="", string EndDate="")
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();              
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;

                if(name!="")
                {
                    objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode) as RowNo,softCodeDefine, softwareCode,softwareName,vahedName,zoneName,companyName,softwareInfo.endDateSupport from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode  where softwareInfo.softwareName like N'%" + name + "%' and (softwareInfo.deleted=0 or softwareInfo.deleted is null) ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                    objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode  where softwareInfo.softwareName like N'%" + name + "%' and (softwareInfo.deleted=0 or softwareInfo.deleted is null)";
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                
                }
                else if(nameSherkat!="")
                  {
                      objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode) as RowNo,softCodeDefine,softwareCode,softwareName,vahedName,zoneName,companyName,softwareInfo.endDateSupport from  softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where softwareInfo.companyName like N'%" + nameSherkat + "%' and (softwareInfo.deleted=0 or softwareInfo.deleted is null) ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                      objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                      objDataAdapter.Fill(objDatatable);
                      objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from  softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where softwareInfo.companyName like N'%" + nameSherkat + "%' and (softwareInfo.deleted=0 or softwareInfo.deleted is null)";
                      objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                      objDataAdapter.Fill(objDatatable);
                
                   }
                else if (vahedSAzmaniCode != 0)
                {
                    if (zoneCode == 0)
                    {
                        objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode) as RowNo,softwareCode,softCodeDefine,softwareName,vahedName,zoneName,companyName,softwareInfo.endDateSupport from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode  where vahedInfo.vahedCode=" + vahedSAzmaniCode + " and  (softwareInfo.deleted=0 or softwareInfo.deleted is null) ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                        objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                        objDataAdapter.Fill(objDatatable);
                        objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode  where vahedInfo.vahedCode=" + vahedSAzmaniCode + " and  (softwareInfo.deleted=0 or softwareInfo.deleted is null)";
                        objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                        objDataAdapter.Fill(objDatatable);
                    }
                    else
                    {
                        objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode) as RowNo, softwareCode,softCodeDefine,softwareName,vahedName,zoneName,companyName,softwareInfo.endDateSupport from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode  where vahedInfo.vahedCode=" + vahedSAzmaniCode + "and zoneInfo.zoneCode=" + zoneCode + " and  (softwareInfo.deleted=0 or softwareInfo.deleted is null) ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                        objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                        objDataAdapter.Fill(objDatatable);
                        objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode  where vahedInfo.vahedCode=" + vahedSAzmaniCode + "and zoneInfo.zoneCode=" + zoneCode + " and  (softwareInfo.deleted=0 or softwareInfo.deleted is null)";
                        objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                        objDataAdapter.Fill(objDatatable);
                    }
                }
                else
                {
                    objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode) as RowNo, softwareCode,softCodeDefine,softwareName,vahedName,zoneName,companyName,softwareInfo.endDateSupport from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode  where softwareInfo.endDateSupport between '" + StartDate + "' and '" + EndDate + "' and  (softwareInfo.deleted=0 or softwareInfo.deleted is null) ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                    objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode  where softwareInfo.endDateSupport between '" + StartDate + "' and '" + EndDate + "' and  (softwareInfo.deleted=0 or softwareInfo.deleted is null)";
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                
                }
               
                dA.disconnect();
                return objDatatable;
            }
            catch(Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }

        }
        public softwareInfo Detailsoftware(Int16 softwareCode)
        {
            
            try{
                var v = from i in db.softwareInfos
                        where i.softwareCode == softwareCode
                        select i;
                softwareInfo newsoftware = v.FirstOrDefault();
                return newsoftware;

        }
            catch (Exception error)
            {
                softwareInfo newsoft = new softwareInfo();
                newsoft.softwareCode = -1;
                return newsoft;
            }
        }
        public DataTable searchZone(string name,int firstRow,int lastRow)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by zoneCode) as RowNo, zoneCode,zoneName from zoneInfo where zoneInfo.zoneName like N'" + name + "%' and zoneInfo.deleted != 1 or zoneInfo.deleted is null)select * from temp where  RowNo between " + firstRow + " and " + lastRow;
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);

                objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from zoneInfo where zoneInfo.zoneName like N'" + name + "%' and (zoneInfo.deleted!=1 or zoneInfo.deleted is null)";
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
            
        }
        public DataTable searchUser(string name="")
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                if(name != "")
                {
                    objDataAdapter.SelectCommand.CommandText = "select userCode,fName,+' '+lName,userName from userinfo where userinfo.fName +' '+  userinfo.lName like N'%" + name + "%'  and (userinfo.deleted!=1 or userinfo.deleted is null)";
                }
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }
        public DataTable searchVahed(int firstRow,int lastRow)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;

                objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by vahedCode desc) as RowNo, vahedCode,vahedName from vahedInfo where (vahedInfo.deleted != 1 or vahedInfo.deleted is null))select * from temp where  RowNo between " + firstRow + " and " + lastRow;
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);

                objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from vahedInfo where (vahedInfo.deleted != 1 or vahedInfo.deleted is null) ";
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }

        public DataTable searchVahed(string name, int firstRow,int lastRow)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by vahedCode) as RowNo, vahedCode,vahedName from vahedInfo where vahedInfo.vahedName like N'%" + name + "%'and (vahedInfo.deleted!=1 or vahedInfo.deleted is null))select * from temp where  RowNo between " + firstRow + " and " + lastRow;
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);

                objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from vahedInfo where vahedInfo.vahedName like N'%" + name + "%'and (vahedInfo.deleted!=1 or vahedInfo.deleted is null)";
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }
     
        public DataTable fillCombo(string table, string ValueMemberField, string DisplayMemberField)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;

               
                objDataAdapter.SelectCommand.CommandText = "select " + ValueMemberField + ", " + DisplayMemberField + " from " + table + " where "+ table +".deleted != 1 or "+ table+".deleted is null";


                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;

            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }
        public Results<userinfo> checkUserPass(string userName, string pass)
        {
            Results<userinfo> result = new Results<userinfo>();
            try
            {
                var u = from i in db.userinfos
                        where i.userName == userName && i.pass == pass
                        select i;
                userinfo ui = u.FirstOrDefault();
                if (ui != null)
                {
                    result.Value = ui;
                    result.Message = "";
                    result.IsSuccessfull = true;
                }
                else
                {
                    result.Value = ui;
                    result.Message = "نام کاربری یا رمز عبور اشتباه است";
                    result.IsSuccessfull = false;
                }
                return result;

            }
            catch(Exception error)
            {
                result.Message = error.ToString();
                result.IsSuccessfull = false;
                return result;
            }
        }

        public DataTable searchZone(int firstRow,int lastRow)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by zoneCode desc) as RowNo, zoneCode,zoneName from zoneInfo where zoneInfo.deleted != 1 or zoneInfo.deleted is null )select * from temp where  RowNo between " + firstRow + " and " + lastRow;
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);

                objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from zoneInfo where (zoneInfo.deleted != 1 or zoneInfo.deleted is null) ";
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }
        public DataTable searchSoftware1(Int16 userCode, int firstRow,int lastRow)
        {
           
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                if (System.Web.HttpContext.Current.Session["admin"].ToString() =="True" )
                {
                    if (userCode != 0)
                    {
                        objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode desc) as RowNo,softCodeDefine, softwareCode,softwareName,vahedName,zoneName,companyName,endDateSupport from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where softwareInfo.deleted!=1 or softwareInfo.deleted is null ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                        objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                        objDataAdapter.Fill(objDatatable);
                        objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode desc) as RowNo,softCodeDefine, softwareCode,softwareName,vahedName=N'همه واحدها',zoneName,companyName,endDateSupport from softwareInfo inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where isAllVahed=1 and (softwareInfo.deleted!=1 or softwareInfo.deleted is null) ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                        objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                        objDataAdapter.Fill(objDatatable);
                        objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where softwareInfo.deleted!=1 or softwareInfo.deleted is null";
                        objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                        objDataAdapter.Fill(objDatatable);
                        objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt1 from softwareInfo inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where isAllVahed=1 and (softwareInfo.deleted!=1 or softwareInfo.deleted is null)";
                        objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                        objDataAdapter.Fill(objDatatable);


                    }

                }
                else
                {
                    objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode desc) as RowNo,softCodeDefine, softwareCode,softwareName,vahedName,zoneName,companyName,endDateSupport from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where softwareInfo.userCode=" + userCode + " and (softwareInfo.deleted!=1 or softwareInfo.deleted is null) ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                    objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by softwareCode desc) as RowNo,softCodeDefine,  softwareCode,softwareName,vahedName=N'همه واحدها',zoneName,companyName,endDateSupport from softwareInfo inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where isAllVahed=1 and softwareInfo.userCode=" + userCode + " and (softwareInfo.deleted!=1 or softwareInfo.deleted is null) ) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                    objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from softwareInfo inner join vahedInfo on softwareInfo.vahedCode=vahedInfo.vahedCode inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where softwareInfo.deleted!=1 or softwareInfo.deleted is null";
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                    objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt1 from softwareInfo inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where isAllVahed=1 and (softwareInfo.deleted!=1 or softwareInfo.deleted is null)";
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                }
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }

        }
        public DataTable searchUser(int firstRow,int lastRow)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by userCode desc) as RowNo,userCode,fName+' '+lName as Name,userName,mobile,email from userinfo where userinfo.deleted!=1 or userinfo.deleted is null )select * from temp where  RowNo between " + firstRow + " and " + lastRow;
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from userInfo where (userInfo.deleted != 1 or userInfo.deleted is null) ";
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }

        public DataTable searchUser(int firstRow ,int lastRow,string Name="", string UserName="")
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                if (UserName == "")
                {
                    objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by userCode) as RowNo, userCode,fName+' '+lName as Name,userName,mobile,email from userinfo  where fName+' '+lName like N'%" + Name + "%' and (userinfo.deleted!=1 or userinfo.deleted is null)) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                    objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from userinfo  where fName+' '+lName like N'%" + Name + "%' and (userinfo.deleted!=1 or userinfo.deleted is null)";
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                }

                else if (Name == "")
                {
                    objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by userCode) as RowNo, userCode,fName+' '+lName as Name,userName,mobile,email from userinfo where userName like N'%" + UserName + "%'  and (userinfo.deleted!=1 or userinfo.deleted is null)) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                    objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from userinfo where userName like N'%" + UserName + "%'  and (userinfo.deleted!=1 or userinfo.deleted is null)";
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                }
                else
                {
                    objDataAdapter.SelectCommand.CommandText = "with temp as (select Row_Number() over (order by userCode) as RowNo, userCode,fName+' '+lName as Name,userName,mobile,email from userinfo where fName+' '+lName like N'%" + Name + "%'  and userName like N'%" + UserName + "%' and (userinfo.deleted!=1 or userinfo.deleted is null)) select * from temp where RowNo between " + firstRow + " and " + lastRow;
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                    objDataAdapter.SelectCommand.CommandText = " select count(*) as cnt from userinfo where fName+' '+lName like N'%" + Name + "%'  and userName like N'%" + UserName + "%' and (userinfo.deleted!=1 or userinfo.deleted is null) ";
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);
                }
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
            
        }

        public DataTable searchSoftware2(Int16 softwareCode)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;

                if (softwareCode != 0)
                {
                    objDataAdapter.SelectCommand.CommandText = "select * from softwareInfo  where softwareInfo.softwareCode=" + softwareCode + " and (softwareInfo.deleted!=1 or softwareInfo.deleted is null )";
                    objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                    objDataAdapter.Fill(objDatatable);

                    //objDataAdapter.SelectCommand.CommandText = "select distinct softwareCode,softwareName,vahedName=N'همه واحدها',zoneName,companyName,softwareInfo.description from softwareInfo inner join zoneInfo on softwareInfo.zoneCode=zoneInfo.zoneCode where softwareInfo.deleted!=1 and isAllVahed=1";
                }




                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }

        public DataTable searchUser(Int16 userCode)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                objDataAdapter.SelectCommand.CommandText = "select * from userinfo where userinfo.userCode=" + userCode + " and (userinfo.deleted!=1 or userinfo.deleted is null) ";
                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }

        public DataTable searchZone1(short zoneCode)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;

                objDataAdapter.SelectCommand.CommandText = "select zoneCode,zoneName from zoneInfo where zoneCode=" + zoneCode + " and zoneInfo.deleted!=1 or zoneInfo.deleted is null ";

                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }

        public DataTable searchVahed1(short vahedCode)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;


                objDataAdapter.SelectCommand.CommandText = "select vahedCode,vahedName,city from vahedInfo where vahedInfo.vahedCode=" + vahedCode + " and (vahedInfo.deleted!=1 or vahedInfo.deleted is null) ";

                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }

        public DataTable searchVahedUser(Int16 userCode)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                objDataAdapter.SelectCommand.CommandText = "select VahedUser.vahedCode ,vahedName from VahedUser inner join vahedInfo on VahedUser.vahedCode = vahedInfo.vahedCode where  VahedUser.userCode =" + userCode + "and (VahedUser.deleted!=1 or VahedUser.deleted is null) ";

                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                return objDatatable;
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return objDatatable;
            }
        }
        
      public bool checkUniqValue(string name,string valueField,string table)
        {
            DataTable objDatatable = new DataTable();
            try
            {
                dA.connect();
                SqlDataAdapter objDataAdapter = new SqlDataAdapter();
                objDatatable.Rows.Clear();
                objDataAdapter.SelectCommand = new SqlCommand();
                objDataAdapter.SelectCommand.Connection = dA.con;
                objDataAdapter.SelectCommand.CommandText = "select " + valueField + "  from " + table + " where  " + table + "." + valueField + " = N'" + name + "' and (" + table + ".deleted!=1 or " + table + ".deleted is null) ";

                objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                objDataAdapter.Fill(objDatatable);
                dA.disconnect();
                if (objDatatable.Rows.Count == 0)
                {
                    return true;
                }

                else
                {
                    return false;
                }
            }
            catch (Exception error)
            {
                if (dA.con.State == ConnectionState.Open)
                    dA.disconnect();
                return false;
            }
        }

      public bool checkUniqValue(string name,string city)
      {
          DataTable objDatatable = new DataTable();
          try
          {
              dA.connect();
              SqlDataAdapter objDataAdapter = new SqlDataAdapter();
              objDatatable.Rows.Clear();
              objDataAdapter.SelectCommand = new SqlCommand();
              objDataAdapter.SelectCommand.Connection = dA.con;
              objDataAdapter.SelectCommand.CommandText = "select vahedCode from vahedInfo where vahedInfo.vahedName= N'" + name + "' and vahedInfo.city= N'"+city+"' and (vahedInfo.deleted!=1 or vahedInfo.deleted is null) ";

              objDataAdapter.SelectCommand.CommandType = CommandType.Text;
              objDataAdapter.Fill(objDatatable);
              dA.disconnect();
              if (objDatatable.Rows.Count == 0)
              {
                  return true;
              }

              else
              {
                  return false;
              }
          }
          catch (Exception error)
          {
              if (dA.con.State == ConnectionState.Open)
                  dA.disconnect();
              return false;
          }
      }

      public int checkUniqUser(string userName)
      {
          DataTable objDatatable = new DataTable();
          try
          {
              dA.connect();
              SqlDataAdapter objDataAdapter = new SqlDataAdapter();
              SqlDataAdapter objDataAdapter1 = new SqlDataAdapter();
              objDatatable.Rows.Clear();
              objDataAdapter.SelectCommand = new SqlCommand();
              objDataAdapter.SelectCommand.Connection = dA.con;
              objDataAdapter.SelectCommand.CommandText = "select userCode from userInfo where  userInfo.userName= N'" + userName + "' and (userInfo.deleted!=1 or userInfo.deleted is null)  ";

              objDataAdapter.SelectCommand.CommandType = CommandType.Text;
              objDataAdapter.Fill(objDatatable);
              dA.disconnect();
              if (objDatatable.Rows.Count == 0)
              {
                  return 1;
              }
              else
                  return 2;

              
          }
          catch (Exception error)
          {
              if (dA.con.State == ConnectionState.Open)
                  dA.disconnect();
              return 0;
          }
      }
      public int checkUniqSoftware(string softwareName)
      {
          DataTable objDatatable = new DataTable();
          try
          {
              dA.connect();
              SqlDataAdapter objDataAdapter = new SqlDataAdapter();
              SqlDataAdapter objDataAdapter1 = new SqlDataAdapter();
              objDatatable.Rows.Clear();
              objDataAdapter.SelectCommand = new SqlCommand();
              objDataAdapter.SelectCommand.Connection = dA.con;
              objDataAdapter.SelectCommand.CommandText = "select softwareCode from softwareInfo where  softwareInfo.softwareName= N'" + softwareName + "' and (softwareInfo.deleted!=1 or softwareInfo.deleted is null)  ";

              objDataAdapter.SelectCommand.CommandType = CommandType.Text;
              objDataAdapter.Fill(objDatatable);
              dA.disconnect();
              if (objDatatable.Rows.Count == 0)
              {
                  return 1;
              }
              else
                  return 2;


          }
          catch (Exception error)
          {
              if (dA.con.State == ConnectionState.Open)
                  dA.disconnect();
              return 0;
          }
      }

      public DataTable searchUpgrade(short softwareCode)
      {

          DataTable objDatatable = new DataTable();
          try
          {
              dA.connect();
              SqlDataAdapter objDataAdapter = new SqlDataAdapter();
              objDatatable.Rows.Clear();
              objDataAdapter.SelectCommand = new SqlCommand();
              objDataAdapter.SelectCommand.Connection = dA.con;

              if (softwareCode != 0)
              {
                  objDataAdapter.SelectCommand.CommandText = "select * from upgrade  where upgrade.softwareCode=" + softwareCode + " and (upgrade.deleted!=1 or upgrade.deleted is null )";
                  objDataAdapter.SelectCommand.CommandType = CommandType.Text;
                  objDataAdapter.Fill(objDatatable);
              }
              objDataAdapter.SelectCommand.CommandType = CommandType.Text;
              objDataAdapter.Fill(objDatatable);
              dA.disconnect();
              return objDatatable;
          }
          catch (Exception error)
          {
              if (dA.con.State == ConnectionState.Open)
                  dA.disconnect();
              return objDatatable;
          }
      }
    }
}
