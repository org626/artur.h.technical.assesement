using AzureWebApp.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace AzureWebApp.Controllers
{
    public class CheckController : Controller
    {
        private readonly AppDbContext _context;
        public CheckController(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            string status;
            try
            {
                await _context.Database.OpenConnectionAsync();
                status = "Database connection successful.";
                await _context.Database.CloseConnectionAsync();
            }
            catch
            {
                status = "Database connection failed.";
            }
            ViewBag.Status = status;
            return View();
        }
    }
}
