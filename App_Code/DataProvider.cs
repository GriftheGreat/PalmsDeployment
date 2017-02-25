using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApplication1
{
    public partial class DataProvider
    {
        public static string mytext = " got connected!";

        public string status
        {
            get { return "good"; }
            set { status = value; }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        public float j(int a, int b)
        {
            return a * b;
        }
    }
}