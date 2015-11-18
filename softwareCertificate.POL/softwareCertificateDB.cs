using System.Configuration;
namespace softwareCertificate.POL
{
    partial class softwareCertificateDBDataContext
    {
        public softwareCertificateDBDataContext()
            : base(ConfigurationManager.ConnectionStrings["softwareCertificate"].ConnectionString, mappingSource)
{
OnCreated();
}
    }
}
