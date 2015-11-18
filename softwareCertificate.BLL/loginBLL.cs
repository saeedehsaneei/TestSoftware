using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using softwareCertificate.POL;
using softwareCertificate.DALL;
using System.Data;
using System.Data.Linq;
using System.Net;
using System.Net.Mail;


namespace softwareCertificate.BLL
{
    public class loginBLL
    {

        public object searchUserEmail(string user, string Email)
        {
            Results<string> result = new Results<string>();
            HelperData h = new HelperData();
            try
            {
                result.Value = h.searchUserEmail(user, Email);
                if (result.Value != "0" && result.Value != "-1")
                {
                    result.IsSuccessfull = true;
                    result.Message = "";
                }
                else
                {
                    result.IsSuccessfull = false;
                    result.Message = "نام کاربری یا آدرس ایمیل وارد شده اشتباه میباشد";
                }
                return result;
            }
            catch
            {
                result.IsSuccessfull = false;
                result.Message = "ارتباط با پایگاه داده برقرار نشد. خطای شماره 190";
                return result;
            }
        }

        public object sendEmail(string user, string email)
        {
            Results<string> result = new Results<string>();
            try
            {
                SmtpClient smtp = new SmtpClient("smtp.mail.yahoo.com");
                smtp.EnableSsl = true;
                smtp.Credentials = new NetworkCredential("salimeh_habibi@yahoo.com", "sally_bam66");
                MailMessage m = new MailMessage();
                m.SubjectEncoding = System.Text.Encoding.UTF8;
                m.BodyEncoding = System.Text.Encoding.UTF8;
                m.From = new MailAddress("salimeh_habibi@yahoo.com");
                m.To.Add(email);
                m.Subject = "تغییر رمز عبور سامانه ";
                m.Body = "با سلام.رمز عبور جدید شما برای ورود به سامانه ثبت شناسنامه ی نرم افزارها عبارت : "+user+" میباشد. ";
                smtp.Send(m);
                result.IsSuccessfull = true;
                return result;
            }

            catch (Exception error)
            {
                result.IsSuccessfull = false;
                result.Message = "امکان ارسال ایمیل نمیباشد. خطای شماره 192" + Environment.NewLine + error.Message;
                return result;
            }
        }

        public object changPass(string userName)
        {
            Results<string> result = new Results<string>();
            HelperData h = new HelperData();
            try
            {
                string  newPass = new CustomMembershipProvider().EncryptPassword(userName);
                result.Value = h.changPass(userName, newPass);
                if (result.Value != "0")
                {
                    result.IsSuccessfull = true;
                    result.Message = "";
                }
                else
                {
                    result.IsSuccessfull = false;
                   
                }
                return result;
            }
            catch
            {
                result.IsSuccessfull = false;
                result.Message = "ارتباط با پایگاه داده برقرار نشد. خطای شماره 190";
                return result;
            }
        }
    }
}
