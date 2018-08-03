using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace DemoWebWinContainerFullFramework.Controllers
{
    public class PingController : ApiController
    {
        [AllowAnonymous]
        [Route("ping")]
        [System.Web.Http.HttpGet]
        public IHttpActionResult GetPing()
        {
            return Ok($"Pong {DateTime.Now.ToString()}");
        }

        [Authorize]
        [Route("PingSecure")]
        [System.Web.Http.HttpGet]
        public IHttpActionResult GetPingSecure()
        {
            return Ok($"Hello {GetUserFullName()}");
        }

        private string GetUserFullName()
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
