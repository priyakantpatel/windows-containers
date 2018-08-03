using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace DemoWebWinContainerFullFramework.Controllers
{
    public class AppSettingsController : ApiController
    {
        [AllowAnonymous]
        [Route("appsettings")]
        [System.Web.Http.HttpGet]
        public IHttpActionResult GetAppSettings()
        {
            var appsettings = new Dictionary<string, string>();

            foreach (var key in ConfigurationManager.AppSettings.AllKeys)
            {
                appsettings[key] = ConfigurationManager.AppSettings[key];
            }

            return Ok(appsettings);
        }
    }
}
