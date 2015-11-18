using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using softwareCertificate.POL;

namespace softwareCertificate.DALL
{
    public class HelperData
    {
        softwareCertificateDBDataContext db = new softwareCertificateDBDataContext();
        //Add To ZoneInfo Table
        public int AddZone(zoneInfo zi)
        {
            helperSearch h = new helperSearch();
            try {
                if (h.checkUniqValue(zi.zoneName, "zoneName", "zoneInfo"))
                {
                    db.zoneInfos.InsertOnSubmit(zi);
                    db.SubmitChanges();
                    return 1;
                }
                else
                {
                    return 0;
                }
                }
            catch (Exception error)
            {
                return 3;
            }
        }
        //Edit ZoneInfo Table
        public int EditZone(zoneInfo zi)
        {
            try
            {
                var v = from i in db.zoneInfos
                        where i.zoneCode == zi.zoneCode
                        select i;
                zoneInfo newzone = v.FirstOrDefault();
                if(newzone != null)
                {
                    newzone = zi;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }

        }
        //Delete From ZoneInfo Table
        public int DeleteZoneInfo(Int16 code)
        {
            try
            {
                var v = from i in db.zoneInfos
                        where i.zoneCode == code
                        select i;
                zoneInfo newzone = v.FirstOrDefault();
                if (newzone != null)
                {
                    newzone.deleted = true;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }
        }
        //Add to VahedInfo Table
        public int AddVahed(vahedInfo vi)
        {
            helperSearch h = new helperSearch();
            try
            {
                if (h.checkUniqValue(vi.vahedName, vi.city))
                {
                    db.vahedInfos.InsertOnSubmit(vi);
                    db.SubmitChanges();
                    return 1;
                }
                else return 0;
            }
            catch (Exception error)
            {
                return 3;
            }
        } 
        //Edit VahedInfo Table
        public int EditVahedInfo(vahedInfo vi)
        {
            try
            {
                var v = from i in db.vahedInfos
                        where i.vahedCode == vi.vahedCode
                        select i;
                vahedInfo newvahed = v.FirstOrDefault();
                if(newvahed != null)
                {
                    newvahed = vi;
                    db.SubmitChanges();
                    return 1;
                }
                 return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }
            
        }
        //Delete From VahedInfo Table
        public int DeleteVahedInfo(Int16 code)
        {
            try
            {
                var v = from i in db.vahedInfos
                        where i.vahedCode == code
                        select i;
                vahedInfo newvahed = v.FirstOrDefault();
                if (newvahed != null)
                {
                    newvahed.deleted = true;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }
            
        }
        //Add To UserInfo Table
        public Int16 AddUserInfo(userinfo ui)
        {
            try{
                    db.userinfos.InsertOnSubmit(ui);
                    db.SubmitChanges();
                    return ui.userCode;
                }
                
            
            catch (Exception error)
            {
                return 0;
            }
        }
        //Edit UserInfo Table
        public int EditUserInfo(userinfo ui)
        {
            try
            {
                var v = from i in db.userinfos
                        where i.userCode == ui.userCode
                        select i;
                userinfo newuser = v.FirstOrDefault();
                if(newuser!= null)
                {
                    newuser.userCode = ui.userCode;
                    newuser.fName = ui.fName;
                    newuser.lName = ui.lName;
                    newuser.userName = ui.userName;
                    newuser.pass = ui.pass;
                    newuser.email = ui.email;
                    newuser.mobile = ui.mobile;
                    newuser.zoneCode = ui.zoneCode;
                    
                    newuser.deleted = false;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found

            }
            catch (Exception error)
            {
                return -1;
            }
        }
        //Delete From UserInfo Table
        public int DeleteUserInfo(Int16 code)
        {
            try
            {
                var v = from i in db.userinfos
                        where i.userCode == code
                        select i;
                userinfo newuser = v.FirstOrDefault();
                if(newuser != null)
                {
                    newuser.deleted = true;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }

        }
        //Add To Upgrade Table
        public bool AddUpgrade(upgrade u)
        {
            try
            {
                db.upgrades.InsertOnSubmit(u);
                db.SubmitChanges();
                return true;
            }
            catch (Exception error)
            {
                return false;
            }
        }
        //Edit Upgrade Table
        public int EditUpgrade(upgrade u)
        {
            try
            {
                var v = from i in db.upgrades
                        where i.upgradeCode == u.upgradeCode
                        select i;
                upgrade newupgrade = v.FirstOrDefault();
                if(newupgrade != null)
                {
                    newupgrade = u;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }
        }
        //Delete From Upgrade Table
        public int DeleteUpgrade(Int16 code)
        {
            try
            {
                var v = from i in db.upgrades
                        where i.upgradeCode == code
                        select i;
                upgrade newupgrade = v.FirstOrDefault();
                if(newupgrade != null)
                {
                    newupgrade.deleted = true;
                    db.SubmitChanges();
                    return 1;

                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }
        }
        //Add To SoftwareInfo Table
        public Int16  AddSoftwareInfo(softwareInfo si)
        {
            try
            {
                db.softwareInfos.InsertOnSubmit(si);
                db.SubmitChanges();
                return si.softwareCode;
            }
            catch (Exception error)
            {
                return 0;
            }
        }
        //Edit SoftwareInfo Table
        public int EditSoftwareInfo(softwareInfo si)
        {
            try
            {
                var v = from i in db.softwareInfos
                        where i.softwareCode == si.softwareCode
                        select i;
                softwareInfo newsoftware = v.FirstOrDefault();
                if(newsoftware != null)
                {
                    newsoftware.softwareCode = si.softwareCode;
                    newsoftware.languageCode = si.languageCode;
                    newsoftware.memariCode = si.memariCode;
                    newsoftware.dbCode = si.dbCode;
                    newsoftware.cityInUse = si.cityInUse;
                    newsoftware.softwareName = si.softwareName;
                    newsoftware.serverLocation = si.serverLocation;
                    newsoftware.companyName = si.companyName;
                    newsoftware.softwarePrice = si.softwarePrice;
                    newsoftware.isSupport = si.isSupport;
                    newsoftware.endDateSupport = si.endDateSupport;
                    newsoftware.supportPrice = si.supportPrice;
                    newsoftware.isUsed = si.isUsed;
                    newsoftware.instalationDate = si.instalationDate;
                    newsoftware.contractNumber = si.contractNumber;
                    newsoftware.supportPeriodNumber = si.supportPeriodNumber;
                    newsoftware.supportPeriodType = si.supportPeriodType;
                    newsoftware.isHardwareLock = si.isHardwareLock;
                    newsoftware.isSource = si.isSource;
                    newsoftware.description = si.description;
                    newsoftware.lastDbVersion = si.lastDbVersion;
                    newsoftware.supervisorName = si.supervisorName;
                    newsoftware.supervisorTell = si.supervisorTell;
                    newsoftware.companyNamayandeName = si.companyNamayandeName;
                    newsoftware.supportTell = si.supportTell;
                    newsoftware.isReportCreate = si.isReportCreate;
                    newsoftware.isFixReport = si.isFixReport;
                    newsoftware.userCount = si.userCount;
                    newsoftware.isDocument = si.isDocument;
                    newsoftware.softwareProblem = si.softwareProblem;
                    newsoftware.isPatchUpdate = si.isPatchUpdate;
                    newsoftware.isFtpUpdate = si.isFtpUpdate;
                    newsoftware.isDirectAccessUpdate = si.isDirectAccessUpdate;
                    newsoftware.isOtherUpdate = si.isOtherUpdate;
                    newsoftware.isOpBuyer = si.isOpBuyer;
                    newsoftware.userCode = si.userCode;
                    newsoftware.deleted = false;
                    newsoftware.vahedCode = si.vahedCode;
                    newsoftware.zoneCode = si.zoneCode;
                    newsoftware.isAllVahed = si.isAllVahed;
                    newsoftware.companyTell = si.companyTell;
                    newsoftware.companyAddress = si.companyAddress;
                    newsoftware.subject = si.subject;

                    db.SubmitChanges();
                    return 1;
                } return 0;//not found
            } 
            catch (Exception error)
            {
                return -1;
            }
        }
        //Delete From SoftwareInfo Table
        public int DeleteSoftwareInfo(Int16 code)
        {
            try
            {
                var v = from i in db.softwareInfos
                        where i.softwareCode == code
                        select i;
                softwareInfo newsoftware = v.FirstOrDefault();
                if(newsoftware!= null)
                {
                    newsoftware.deleted = true;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found

            }
            catch (Exception error)
            {
                return -1;
            } 
        }
        //Add To ProgramLanguage Table
        public bool AddProgramLanguage(programLanguage pl)
        {
            try
            {
                db.programLanguages.InsertOnSubmit(pl);
                db.SubmitChanges();
                return true;
            }
            catch (Exception error)
            {
                return false;
            } 

        }
        //Edit ProgramLanguage Table
        public int EditProgramLanguage(programLanguage pl)
        {
            try
            {
                var v = from i in db.programLanguages
                        where i.programLangCode == pl.programLangCode
                        select i;
                programLanguage newprogram = v.FirstOrDefault();
                if(newprogram!= null)
                {
                    newprogram = pl;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
             }
            catch (Exception error)
            {
                return -1;
            } 
        }
        //Delete From ProgramLanguage Table
        public int DeleteProgramLanguage(Int16 code)
        {
            try
            {
                var v = from i in db.programLanguages
                        where i.programLangCode == code
                        select i;
                programLanguage newprogram = v.FirstOrDefault();
                if(newprogram != null)
                {
                    newprogram.deleted = true;
                    db.SubmitChanges();
                    return 1;
                } 
                return 0;//not found
            }
                catch (Exception error)
            {
                return -1;
            } 
            
        }
        //Add to MemariSystem Table
        public bool AddMemariSystem(memariSystem ms)
        {
            try
            {
                db.memariSystems.InsertOnSubmit(ms);
                db.SubmitChanges();
                return true;
            }
            catch (Exception error)
            {
                return false;
            } 
        }
        //Edit MemariSystem Table
        public int EditMemariSystem(memariSystem ms)
        {
            try
            {
                var v = from i in db.memariSystems
                        where i.memariCode == ms.memariCode
                        select i;
                memariSystem newmemari = v.FirstOrDefault();
                if(newmemari != null)
                {
                    newmemari = ms;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            } 
        }
        //Delete From MemariSystem Table
        public int DeleteMemariSystem(Int16 code)
        {
            try
            {
                var v = from i in db.memariSystems
                        where i.memariCode == code
                        select i;
                memariSystem newmemari = v.FirstOrDefault();
                if(newmemari != null)
                {
                    newmemari.deleted = true;
                    db.SubmitChanges();
                    return 1;

                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            } 
        }
        //Add To DB Table
        public bool AddDB(DB d)
        {
            try
            {
                db.DBs.InsertOnSubmit(d);
                db.SubmitChanges();
                return true;
            }

            catch (Exception error)
            {
                return false;
            } 
        }
        //Edit DB Table
        public int EditDB(DB d)

        {
            try
            {
                var v = from i in db.DBs
                        where i.dbCode == d.dbCode
                        select i;
                DB newdb = v.FirstOrDefault();
                if(newdb != null)
                {
                    newdb = d;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found

            }
            catch (Exception error)
            {
                return -1;
            } 
        }
        //Delete DB Table
        public int DeleteDB(Int16 code)
        {
            try
            {
                var v = from i in db.DBs
                        where i.dbCode == code
                        select i;
                DB newdb = v.FirstOrDefault();
                if (newdb != null)
                {
                    newdb.deleted = true;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found

            }
            catch (Exception error)
            {
                return -1;
            }
        }
        //Add To CompanyInfo Table
        public bool AddCompanyInfo(companyInfo ci)
        {
            try
            {
                db.companyInfos.InsertOnSubmit(ci);
                db.SubmitChanges();
                return true;
            }
            catch (Exception error)
            {
                return false;
            }
        }
        //Edit CompanyInfo Table
        public int EditCompanyInfo(companyInfo ci)
        {
            try
            {
                var v = from i in db.companyInfos
                        where i.companyCode == ci.companyCode
                        select i;
                companyInfo newcompany = v.FirstOrDefault();
                if(newcompany != null)
                {
                    newcompany = ci;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }
        }
       
        public bool AddAccessUser(accessUser au)
        {
            try
            {
                db.accessUsers.InsertOnSubmit(au);
                db.SubmitChanges();
                return true;
            }
            catch (Exception error)
            {
                return false;
            }
        }
        //EDIT accessUser Table
        public int EditAccessUser(accessUser au)
        {
            try
            {
                var v = from i in db.accessUsers
                        where i.accessCode == au.accessCode
                        select i;
                accessUser newaccess = v.FirstOrDefault();
                if(newaccess != null)
                {
                    newaccess = au;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }
        }
        //Delete From AccessUser Table
        public int DeleteccessUser(Int16 code)
        {
            try
            {
                var v = from i in db.accessUsers
                        where i.accessCode == code
                        select i;
                accessUser newaccess = v.FirstOrDefault();
                if(newaccess!= null)
                {
                    newaccess.deleted = true;
                    db.SubmitChanges();
                    return 1;
                }
                return 0;//not found
            }
            catch (Exception error)
            {
                return -1;
            }
        }

        public bool AddVahedUser(List<VahedUser> vu,Int16 userCode)
        {
            try
            {
                //db.Connection.Open();
                //using (db.Transaction = db.Connection.BeginTransaction())
                foreach (VahedUser r in vu)
                {
                    r.userCode= userCode;
                    r.deleted = false;
                    db.VahedUsers.InsertOnSubmit(r);
                    db.SubmitChanges();
                }
               // db.Transaction.Commit();
                return true;
               
            }
            catch (Exception error)
            {
                //db.Transaction.Rollback();
                return false;
            }
        }

        public int DeleteVahedUser(Int16 userCode)
        {
            try
            {
                var v = from i in db.VahedUsers
                        where i.userCode == userCode
                        select i;
                //VahedUser newuser = v.FirstOrDefault();
                //if (newuser != null)
                //{
                //    newuser.deleted = true;
                //    db.SubmitChanges();
                //    return 1;
                //}
                foreach (VahedUser vu in v)
                {
                    vu.deleted = true;
                    db.SubmitChanges();
                    
                }
                return 1;
               
            }
            catch (Exception error)
            {
                return -1;
            }
        }
    }
}
