using AzureWebApp.Data;
using AzureWebApp.Models;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace AzureWebApp.Controllers
{
    public class DataController : Controller
    {
        private readonly AppDbContext _context;
        public DataController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index(string column)
        {
            var info = new Info { Column = column };
            _context.InfoItems.Add(info);
            await _context.SaveChangesAsync();
            ViewBag.Message = "Info saved!";
            return View();
        }
    }
}
