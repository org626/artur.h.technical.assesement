using AzureWebApp2.Data;
using AzureWebApp2.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace AzureWebApp2.Controllers
{
    public class InfoController : Controller
    {
        private readonly AppDbContext _context;
        public InfoController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var infoItems = await _context.InfoItems.ToListAsync();
            return View(infoItems);
        }

        [HttpPost]
        public async Task<IActionResult> Update(string column)
        {
            if (!string.IsNullOrEmpty(column))
            {
                var info = new Info { Column = column };
                _context.InfoItems.Add(info);
                await _context.SaveChangesAsync();
                ViewBag.Message = "INFO table updated successfully!";
            }
            else
            {
                ViewBag.Message = "Please provide a valid value.";
            }
            var infoItems = await _context.InfoItems.ToListAsync();
            return View("Index", infoItems);
        }
    }
}
