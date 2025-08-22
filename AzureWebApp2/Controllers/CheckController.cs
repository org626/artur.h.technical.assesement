using AzureWebApp2.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace AzureWebApp2.Controllers
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
            try
            {
                await _context.Database.OpenConnectionAsync();
                await _context.Database.CloseConnectionAsync();
                return Ok("connection is established");
            }
            catch
            {
                return BadRequest("database is unreachable");
            }
        }
    }
}
