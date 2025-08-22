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
            try
            {
                await _context.Database.OpenConnectionAsync();
                await _context.Database.CloseConnectionAsync();
                
                // Return HTTP 200 with success message
                return Ok("connection is established");
            }
            catch
            {
                // Return HTTP 400 with error message
                return BadRequest("database is unreachable");
            }
        }
    }
}
