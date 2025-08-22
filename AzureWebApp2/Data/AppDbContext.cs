using Microsoft.EntityFrameworkCore;
using AzureWebApp2.Models;

namespace AzureWebApp2.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Info> InfoItems { get; set; }
    }
}
