using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PalmsGrilleOnline.Startup))]
namespace PalmsGrilleOnline
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
