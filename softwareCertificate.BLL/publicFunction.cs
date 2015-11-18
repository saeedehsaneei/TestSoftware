using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace softwareCertificate.BLL
{
    class publicFunction
    {
        public string hashPassword(string pass)
        {
            try
            {
                SHA1CryptoServiceProvider sha1 = new SHA1CryptoServiceProvider();
                byte[] input = System.Text.Encoding.UTF8.GetBytes(pass);
                byte[] output = sha1.ComputeHash(input);
                return Convert.ToBase64String(output);
            }
            catch (Exception error)
            {                
                return "";
            }

        }

    }
}
