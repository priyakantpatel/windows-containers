using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoWebWinContainerFullFramework.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Title = "Home Page";

            ViewBag.user = (User.Identity != null) ? User.Identity.Name : "NA";

            ViewBag.displayName = GetUserFullName();

            return View();
        }


        public string GetUserFullName()
        {
            string fullName = "NA";
            using (var context = new System.DirectoryServices.AccountManagement.PrincipalContext(System.DirectoryServices.AccountManagement.ContextType.Domain))
            {
                var principal = System.DirectoryServices.AccountManagement.UserPrincipal.FindByIdentity(context, User.Identity.Name);
                if (principal != null)
                {
                    fullName = string.Format("{0} {1}", principal.GivenName, principal.Surname);
                }
            }

            return fullName;
        }
    }
}
