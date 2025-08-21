using Microsoft.EntityFrameworkCore;
using AzureWebApp.Models;

namespace AzureWebApp.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<AzureWebApp.Models.Info> InfoItems { get; set; }
    }
}
