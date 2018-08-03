using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace DemoWebWinContainerFullFramework.Controllers
{
    public class DbController : ApiController
    {
        [Authorize]
        [Route("product")]
        [System.Web.Http.HttpGet]
        public IHttpActionResult GetProducts()
        {
            try
            {
                using (var db = new DB.ProductModel())
                {
                    var products = db.Products.ToList();
                    return Ok(products);
                }
            }
            catch (Exception ex)
            {
                return Ok(ex.ToString());
            }
        }
    }
}
