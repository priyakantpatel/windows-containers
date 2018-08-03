using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace DemoWebWinContainerFullFramework.Controllers
{
    public class FileIoController : ApiController
    {
        //[Authorize]
        [Route("fileiotest")]
        [System.Web.Http.HttpGet]
        public IHttpActionResult FileIoTest()
        {
            var filePath = ConfigurationManager.AppSettings["testfilepath"];

            try
            {
                //Read file
                var fileStr = File.ReadAllText(Path.Combine(filePath, @"hello.txt"));

                //Write file
                File.WriteAllText(Path.Combine(filePath, @"z-" + DateTime.Now.Ticks.ToString() + ".log"),
                    $"[{Environment.MachineName}] I can also write.");
            }
            catch (Exception ex)
            {
                return Ok(ex.ToString());
            }

            return Ok($"I can read and write: [{filePath}]");
        }
    }
}
